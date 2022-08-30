//
//  PlayViewController.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit

class GameViewController: UIViewController {
    enum MoveState: String {
        case rightDie = "right_die"
        case leftDie = "left_die"
        case rightStop = "right_stop"
        case leftStop = "left_stop"
        case rightRun = "right_run"
        case leftRun = "left_run"
        
        func isRunning() -> Bool{
            return self == .rightRun || self == .leftRun ? true : false
        }
        func isStop() -> Bool {
            return self == .rightStop || self == .leftStop ? true : false
        }
        func isPlaying() -> Bool {
            return self == .rightDie || self == .leftDie ? false : true
        }
        func getDirection() -> String {
            return self == .leftRun || self == .leftStop || self == .leftDie ? "left" : "right"
        }
        
    }
    
    // MARK: - IBOutlets
    let avoiderImageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 200 , width: 40, height: 40))
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
    let pooRandomIntRange: Int = 500
var score: Int = 0 {
    didSet {
        scoreButton.setTitle("\(score)", for: .normal)
    }
}
let gameTimeInterval: Double = 0.0001
let avoiderImageChangeSpeed: UInt32 = 30000
let pooImageChangeSpeed: UInt32 = 1000
let avoiderMovingDistance: Double = 0.1
var moveState = MoveState.leftDie {
    willSet {

        if !newValue.isStop() {
            DispatchQueue.global().async {
                var i = 0
                while true {
                    if self.moveState.isStop() || !self.moveState.isPlaying() {
                        DispatchQueue.main.async {
                            self.avoiderImageView.image = UIImage(named: Asset.Avoider.getImage(n: UserDefaultManager.shared.settings["avoider"] ?? "avoider0", state: self.moveState.rawValue))
                        }
                        break
                    }
                    DispatchQueue.main.async {
                        self.avoiderImageView.image = UIImage(named: Asset.Avoider.getImage(n: UserDefaultManager.shared.settings["avoider"] ?? "avoider0", state: newValue.rawValue, depth: "\(i % 12)"))
                        i += 1
                    }
                    usleep(self.avoiderImageChangeSpeed)
                }
                
            }
        } else {
            DispatchQueue.main.async {
                self.avoiderImageView.image = UIImage(named: Asset.Avoider.getImage(n: UserDefaultManager.shared.settings["avoider"] ?? "avoider0", state: self.moveState.rawValue))
            }
        }
        
        
    }
}


@objc
func progress(){
    var d: CGFloat = 0
    //속도
    if moveState == MoveState.rightRun {
        d = avoiderMovingDistance
    } else if moveState == MoveState.leftRun {
        d = avoiderMovingDistance * -1
    }
    let tempTime = Int(Date().timeIntervalSince(startTime))
    if let timeText = timeButton.titleLabel?.text  {
        if timeText != "\(tempTime)"{
            timeButton.setTitle("\(tempTime)", for: .normal)
            score += 50
        }
    }
    
    let avoiderX = avoiderImageView.center.x
    let avoiderY = view.safeAreaLayoutGuide.layoutFrame.maxY - 30
    let avoiderSize = (avoiderImageView.frame.width, avoiderImageView.frame.height)
    if avoiderX + d > 0 && avoiderX + d < UIScreen.main.bounds.width {
        avoiderImageView.center = CGPoint(x: avoiderX + d, y: avoiderY)
        
    }
    
    let randomInt = Int.random(in: 0..<pooRandomIntRange) // 똥
    if randomInt == 0 {
        let randomWidth = CGFloat.random(in: 0..<UIScreen.main.bounds.width)
        let randomSpeed = CGFloat.random(in: 0.2..<0.5)
        var p = Poo(x: CGFloat(randomWidth), y: -50, speed: randomSpeed)
        view.insertSubview(p.pooImageView, at: view.subviews.count - 2)
        DispatchQueue.global().async {
            while self.moveState.isPlaying() {
                p.y += p.speed
                if p.y - 5 > avoiderY {
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
                if avoiderY - avoiderSize.1 / 2 < p.y + p.height / 2 - 10 {
                    DispatchQueue.main.async {
                        let pooLeft = p.x - p.width / 2 + 10
                        let pooRight = p.x + p.width / 2 - 10
                        let avoiderLeft = self.avoiderImageView.frame.minX
                        let avoiderRight = self.avoiderImageView.frame.maxX
                        if avoiderLeft < pooLeft && pooLeft < avoiderRight || avoiderLeft < pooRight && pooRight < avoiderRight {
                            self.gameOver()
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
    moveState = moveState.getDirection() == "left" ? MoveState.leftDie : MoveState.rightDie
    timer?.invalidate()
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {

        
        let nextVC = EndViewController()
        nextVC.score = self.score
        
        // TODO: - 화면 전환
        nextVC.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.navigationController?.pushViewController(nextVC, animated: false)
    })
    
}

// MARK: - Life Cycle
override func viewDidLoad() {
    super.viewDidLoad()
    
    drawFrame()
    setupBottomImageView()
    setupAvoiderImageView()
    setupLeftMoveButton()
    setupRightMoveButton()
    
    timeButton.setTitle("0", for: .normal)
    timer = Timer.scheduledTimer(timeInterval: gameTimeInterval, target: self, selector: #selector(progress), userInfo: nil, repeats: true)
    setupScoreButton()
    setupTimeButton()
    
    moveState = MoveState.rightStop
}

override func viewWillAppear(_ animated: Bool) {
    BGMManager.shared.playMusic(self)
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
    moveState = MoveState.rightStop
    
}
func setupLeftMoveButton(){
    view.addSubview(leftMoveButton)
    
    leftMoveButton.setImage(UIImage(named: Asset.ETC.left)?.setSizeImage(height: moveButtonSize, width: moveButtonSize), for: .normal)
    leftMoveButton.snp.makeConstraints {
        $0.centerY.equalToSuperview().offset(150)
        $0.leading.equalToSuperview().inset(20)
    }
    leftMoveButton.addTarget(self, action: #selector(moveAvoider(_:)), for: .touchDown)
    leftMoveButton.addTarget(self, action: #selector(stopAvoider(_:)), for: .touchUpInside)
    leftMoveButton.addTarget(self, action: #selector(stopAvoider(_:)), for: .touchUpOutside)
    
}


func setupRightMoveButton(){
    view.addSubview(rightMoveButton)
    
    rightMoveButton.setImage(UIImage(named: Asset.ETC.right)?.setSizeImage(height: moveButtonSize, width: moveButtonSize), for: .normal)
//    rightMoveButton.transform = .init(rotationAngle: CGFloat.pi)
    
    rightMoveButton.snp.makeConstraints {
        $0.centerY.equalToSuperview().offset(150)
        $0.trailing.equalToSuperview().inset(20)
    }
    rightMoveButton.addTarget(self, action: #selector(moveAvoider(_:)), for: .touchDown)
    rightMoveButton.addTarget(self, action: #selector(stopAvoider(_:)), for: .touchUpInside)
    rightMoveButton.addTarget(self, action: #selector(stopAvoider(_:)), for: .touchUpOutside)
}
func setupBottomImageView(){
    view.addSubview(bottomImageView)
    
    bottomImageView.image = UIImage(named: Asset.ETC.bottom)
    bottomImageView.contentMode = .scaleAspectFit
    
    bottomImageView.snp.makeConstraints {
        $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        $0.top.equalToSuperview().offset(view.safeAreaLayoutGuide.layoutFrame.maxY - 15 - avoiderImageView.frame.height)
    }
}
@objc
func moveAvoider(_ sender: UIButton){
    if sender == rightMoveButton {
        moveState = MoveState.rightRun
    } else {
        moveState = MoveState.leftRun
    }
}
@objc
func stopAvoider(_ sender: UIButton){
    if moveState.isRunning() {
        moveState = moveState.getDirection() == "left" ? MoveState.leftStop : MoveState.rightStop
    }
}

}
