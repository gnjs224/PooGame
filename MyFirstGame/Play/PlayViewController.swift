//
//  PlayViewController.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit

class PlayViewController: UIViewController {
    enum MoveState: String {
        case stop = "stop"
        case right = "right"
        case left = "left"
    }
    
    // MARK: - IBOutlets
    let avoiderImageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 200 , width: 30, height: 30))
    let scoreButton = UIButton()
    let leftMoveButton = UIButton()
    let rightMoveButton = UIButton()
    let timeButton = UIButton()
    let startTime = Date()
    let bottomImageView = UIImageView()
    
    // MARK: - Properties
    let moveButtonSize:CGFloat = UIScreen.main.bounds.width / 5
    var timer: Timer?
    let deviceWidth: Int = Int(UIScreen.main.bounds.width)
    let deviceHeight: Int = Int(UIScreen.main.bounds.height)
    var isPlaying: Bool = true
    var score: Int = 0 {
        didSet {
            scoreButton.setTitle("\(score)", for: .normal)
        }
    }
    let gameTimeInterval: Double = 0.001
    let avoiderImageChangeSpeed: UInt32 = 30000
    let pooImageChangeSpeed: UInt32 = 1000
    let avoiderMovingDistance: Double = 0.1
    var moveState = MoveState.stop {
        willSet {
            if newValue != .stop {
                DispatchQueue.global().async {
                    
                    var i = 0
                    while true {
                        var type:String = "run"
                        if !self.isPlaying {
                            type = "die"
                        }
                        if self.moveState == MoveState.stop {
                            type = self.moveState.rawValue
                        }
                        if type != "run" {
                            DispatchQueue.main.async {
                                
                                self.avoiderImageView.image = UIImage(named: Asset.Avoider.getImage(n: UserDefaultManager.shared.settings["character"] ?? "character0", d: newValue.rawValue, type: self.moveState.rawValue))
                            }
                            break
                        }
                        if self.moveState != newValue {
                            break
                        }
                        DispatchQueue.main.async {
                            print(self.moveState)
                            self.avoiderImageView.image = UIImage(named: Asset.Avoider.getImage(n: UserDefaultManager.shared.settings["character"] ?? "character0", d: newValue.rawValue, type: "run", depth: "\(i % 12)"))
                            i += 1
                            print(i)
                        }
                        usleep(self.avoiderImageChangeSpeed)
                    }
                    
                }
            }
            
        }
    }
    
    
    @objc
    func progress(){
        var d: CGFloat = 0
        //속도
        if moveState == MoveState.right {
            d = avoiderMovingDistance
        } else if moveState == MoveState.left {
            d = avoiderMovingDistance * -1
        }
        let tempTime = Int(Date().timeIntervalSince(startTime))
        if let timeText = timeButton.titleLabel?.text  {
            if timeText != "\(tempTime)"{
                timeButton.setTitle("\(tempTime)", for: .normal)
                score += 50
            }
        }
        
        let characterX = avoiderImageView.center.x
        let characterY = view.safeAreaLayoutGuide.layoutFrame.maxY - 30
        let characterSize = (avoiderImageView.frame.width, avoiderImageView.frame.height)
        if characterX + d > 0 && characterX + d < UIScreen.main.bounds.width {
            avoiderImageView.center = CGPoint(x: characterX + d, y: characterY)
            
        }
        
        let randomInt = Int.random(in: 0..<500) // 똥
        if randomInt == 0 {
            let randomWidth = CGFloat.random(in: 0..<UIScreen.main.bounds.width)
            let randomSpeed = CGFloat.random(in: 0.2..<0.5)
            var p = Poo(x: CGFloat(randomWidth), y: -50, speed: randomSpeed)
            view.insertSubview(p.pooImageView, at: view.subviews.count - 2)
            DispatchQueue.global().async {
                while self.isPlaying {
                    p.y += p.speed
                    if p.y - 5 > characterY {
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.4) {
                                p.pooImageView.alpha = 0
                            } completion: { Bool in
                                p.pooImageView.removeFromSuperview()
                            }
                            self.score += 70
                        }
                        break
                    }
                    if characterY - characterSize.1 / 2 < p.y + p.height / 2 - 5 {
                        DispatchQueue.main.async {
                            let pooLeft = p.x - p.width / 2 + 5
                            let pooRight = p.x + p.width / 2 - 5
                            let characterLeft = self.avoiderImageView.frame.minX
                            let characterRight = self.avoiderImageView.frame.maxX
                            if characterLeft < pooLeft && pooLeft < characterRight || characterLeft < pooRight && pooRight < characterRight {
//                                self.gameOver()
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        p.pooImageView.center = CGPoint(x: p.x, y: p.y)
                    }
                    usleep(self.pooImageChangeSpeed)
                }
                
            }
        }
        
    }
    
    func gameOver() {
        isPlaying = false
        timer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0, execute: {
            let nextVC = EndViewController()
            nextVC.score = self.score
            nextVC.modalPresentationStyle = UIModalPresentationStyle.formSheet
            self.preferredContentSize = CGSize(width: 100, height: 100)
            nextVC.modalTransitionStyle = .crossDissolve
            self.present(nextVC, animated: true)
//            self.navigationController?.pushViewController(nextVC, animated: false)
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomImageView()
        drawFrame()
        
        setupAvoiderImageView()
        setupLeftMoveButton()
        setupRightMoveButton()
        
        timeButton.setTitle("0", for: .normal)
        timer = Timer.scheduledTimer(timeInterval: gameTimeInterval, target: self, selector: #selector(progress), userInfo: nil, repeats: true)
        setupScoreButton()
        setupTimeButton()
    }
    func setupTimeButton() {
        view.addSubview(timeButton)
        
        timeButton.setImage(UIImage(systemName: "timer"), for: .normal)
        timeButton.imageView?.tintColor = .systemBackground
        timeButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -15)
        timeButton.titleLabel?.font = UIFont.customFont(fontSize: 30, type: .둥근모)
        
        timeButton.snp.makeConstraints {
            $0.centerY.equalTo(scoreButton)
            $0.leading.equalToSuperview().offset(70)
        }
        timeButton.setTitleColor(.systemBackground, for: .normal)
        
    }
    func setupScoreButton() {
        view.addSubview(scoreButton)
        scoreButton.setImage(UIImage(named: Asset.ETC.score)?.setSizeImage(height: 30, width: 30), for: .normal)
        scoreButton.setTitle("\(score)", for: .normal)
        scoreButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -15)
        scoreButton.titleLabel?.font = UIFont.customFont(fontSize: 30, type: .둥근모)
        scoreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(90)
            $0.top.equalToSuperview().offset(55)
        }
        scoreButton.setTitleColor(.systemBackground, for: .normal)
    }
    func setupAvoiderImageView(){
        view.addSubview(avoiderImageView)
        avoiderImageView.image = UIImage(named: Asset.Avoider.getImage(n: UserDefaultManager.shared.settings["character"] ?? "character0", d: "right", type: "stop", depth: ""))
        
    }
    func setupLeftMoveButton(){
        view.addSubview(leftMoveButton)
        
        leftMoveButton.setImage(UIImage(named: Asset.ETC.move)?.setSizeImage(height: moveButtonSize, width: moveButtonSize), for: .normal)
        leftMoveButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().inset(20)
        }
        leftMoveButton.addTarget(self, action: #selector(moveCharacter(_:)), for: .touchDown)
        leftMoveButton.addTarget(self, action: #selector(stopCharacter(_:)), for: .touchUpInside)
        leftMoveButton.addTarget(self, action: #selector(stopCharacter(_:)), for: .touchUpOutside)
        
    }
    
    
    func setupRightMoveButton(){
        view.addSubview(rightMoveButton)
        rightMoveButton.setImage(UIImage(named: Asset.ETC.move)?.setSizeImage(height: moveButtonSize, width: moveButtonSize), for: .normal)
        rightMoveButton.transform = .init(rotationAngle: CGFloat.pi)
        rightMoveButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(150)
            $0.trailing.equalToSuperview().inset(20)
        }
        rightMoveButton.addTarget(self, action: #selector(moveCharacter(_:)), for: .touchDown)
        rightMoveButton.addTarget(self, action: #selector(stopCharacter(_:)), for: .touchUpInside)
        rightMoveButton.addTarget(self, action: #selector(stopCharacter(_:)), for: .touchUpOutside)
    }
    func setupBottomImageView(){
        view.addSubview(bottomImageView)
        
        bottomImageView.image = UIImage(named: Asset.ETC.bottom)
        bottomImageView.contentMode = .scaleAspectFit
        
        bottomImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview().offset(view.safeAreaLayoutGuide.layoutFrame.maxY - 55)
        }
    }
    @objc
    func moveCharacter(_ sender: UIButton){
        if sender == rightMoveButton {
            moveState = MoveState.right
        } else {
            moveState = MoveState.left
        }
    }
    @objc
    func stopCharacter(_ sender: UIButton){
        moveState = MoveState.stop
    }
    
}
