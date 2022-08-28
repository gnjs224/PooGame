//
//  PlayViewController.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit

class PlayViewController: UIViewController {
    enum MoveState {
        case stop
        case right
        case left
    }
    
    // MARK: - IBOutlets
    let characterImageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 100 , width: 30, height: 30))
    let scoreButton = UIButton()
    let leftMoveButton = UIButton()
    let rightMoveButton = UIButton()
    let timeButton = UIButton()
    let startTime = Date()
    
    // MARK: - Properties
    var moveState = MoveState.stop
    let moveButtonSize:CGFloat = UIScreen.main.bounds.width / 5
    var timer: Timer?
    let deviceWidth: Int = Int(UIScreen.main.bounds.width)
    let deviceHeight: Int = Int(UIScreen.main.bounds.height)
    var isPlaying: Bool = true
    var score: Int = 0
    let timeInterval: Double = 0.00001
    @objc
    func progress(){
        var d: CGFloat = 0
        //속도
        if moveState == MoveState.right {
            d = 0.3
        } else if moveState == MoveState.left {
            d = -0.3
        }
        let tempTime = Int(Date().timeIntervalSince(startTime))
//        print(timeButton.titleLabel?.text)
        if let timeText = timeButton.titleLabel?.text  {
            if timeText != "\(tempTime)"{
                timeButton.setTitle("\(tempTime)", for: .normal)
                score += 50
            }
        }
        
        let characterX = characterImageView.center.x
        let characterY = view.safeAreaLayoutGuide.layoutFrame.maxY
        let characterSize = (characterImageView.frame.width, characterImageView.frame.height)
        if characterX + d > 0 && characterX + d < UIScreen.main.bounds.width {
            characterImageView.center = CGPoint(x: characterX + d, y: characterY)
        }
        scoreButton.removeFromSuperview()
        setupScoreButton()
        setupTimeButton()
        let randomInt = Int.random(in: 0..<200) // 똥
        if randomInt == 0 {
            let randomWidth = CGFloat.random(in: 0..<UIScreen.main.bounds.width)
            let randomSpeed = CGFloat.random(in: 1..<4.0)
            var p = Poo(x: CGFloat(randomWidth), y: 0, spped: randomSpeed)
            view.addSubview(p.pooImageView)
            
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
                            let characterLeft = self.characterImageView.frame.minX
                            let characterRight = self.characterImageView.frame.maxX
                            if characterLeft < pooLeft && pooLeft < characterRight || characterLeft < pooRight && pooRight < characterRight {
                                self.gameOver()
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        p.pooImageView.center = CGPoint(x: p.x, y: p.y)
                    }
                    usleep(10000)
                }
                
            }
        }

    }
    
    func gameOver() {
        isPlaying = false
        timer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let nextVC = EndViewController()
            nextVC.score = self.score
            self.navigationController?.pushViewController(nextVC, animated: false)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultManager.shared.settings = ["background": "background0", "character": "character0"]
        drawFrame()
        setupScoreButton()
        setupCharacter()
        setupLeftMoveButton()
        setupRightMoveButton()
        setupTimeButton()
        timeButton.setTitle("0", for: .normal)
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(progress), userInfo: nil, repeats: true)
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
        scoreButton.setImage(UIImage(named: "score")?.setSizeImage(height: 30, width: 30), for: .normal)
        scoreButton.setTitle("\(score)", for: .normal)
        scoreButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -15)
        scoreButton.titleLabel?.font = UIFont.customFont(fontSize: 30, type: .둥근모)
        scoreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(90)
            $0.top.equalToSuperview().offset(55)
        }
        scoreButton.setTitleColor(.systemBackground, for: .normal)
    }
    func setupCharacter(){
        view.addSubview(characterImageView)
        
        characterImageView.image = UIImage(named: UserDefaultManager.shared.settings["character"] ?? "character0")
        
    }
    func setupLeftMoveButton(){
        view.addSubview(leftMoveButton)
        
        leftMoveButton.setImage(UIImage(named: "move")?.setSizeImage(height: moveButtonSize, width: moveButtonSize), for: .normal)
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
        rightMoveButton.setImage(UIImage(named: "move")?.setSizeImage(height: moveButtonSize, width: moveButtonSize), for: .normal)
        rightMoveButton.transform = .init(rotationAngle: CGFloat.pi)
        rightMoveButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(150)
            $0.trailing.equalToSuperview().inset(20)
        }
        rightMoveButton.addTarget(self, action: #selector(moveCharacter(_:)), for: .touchDown)
        rightMoveButton.addTarget(self, action: #selector(stopCharacter(_:)), for: .touchUpInside)
        rightMoveButton.addTarget(self, action: #selector(stopCharacter(_:)), for: .touchUpOutside)
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
