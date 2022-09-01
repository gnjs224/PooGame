//
//  ViewController.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/24.
//

import UIKit
import SnapKit
class StartViewController: UIViewController {
    let backgroundImage = UIImageView()
    let titleLabel = UILabel()
    let playButtonView = PlayButtonView(type: "play")
    let scoreTitleLabel = UILabel()
    let scoreLabel = UILabel()
    var avoiderImageView = UIImageView()
    var coordinator: Coordinator?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avoiderImageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 20, y: self.view.safeAreaLayoutGuide.layoutFrame.maxY - 84, width: 40, height: 40))
        
        
        drawFrame(backgroundImage)
        setupPlayButtonView()
        setupTitleLabel()
        setupScoreTitleLabel()
        setupScoreLabel()
        setupAvoiderImageView()
    }
    override func viewWillAppear(_ animated: Bool) {
        BGMManager.shared.playMusic(self)
        scoreLabel.text = "\(UserDefaultManager.shared.maxScore)"
        print("StartViewWillAppear")
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("StartViewdidDisapper")
    }
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = "똥피하기\nby 피터"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        titleLabel.font = UIFont.customFont(fontSize: UserDefaultManager.shared.commonFontSize, type: .둥근모)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(playButtonView.snp.top).offset(-100)
        }
    }
    func setupPlayButtonView() {
        view.addSubview(playButtonView)
        
        playButtonView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(UIScreen.main.bounds.width * 0.5)
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(touchUpPlayButtonView))
        playButtonView.addGestureRecognizer(gesture)
        playButtonView.isUserInteractionEnabled = true
    }
    
    @objc
    func touchUpPlayButtonView(){
        // TODO: - 화면전환
        if let coordinator = coordinator as? StartCoordinator {
            coordinator.showGameViewController()
        }
        
//        navigationController?.pushViewController(GameViewController(), animated: false)
    }
    func setupScoreTitleLabel() {
        view.addSubview(scoreTitleLabel)
        scoreTitleLabel.text = "최고 점수"
        scoreTitleLabel.font = UIFont.customFont(fontSize: UserDefaultManager.shared.commonFontSize, type: .둥근모)
        scoreTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(playButtonView.snp.bottom).offset(100)
        }
    }
    func setupScoreLabel() {
        view.addSubview(scoreLabel)
        
        scoreLabel.font = UIFont.customFont(fontSize: UserDefaultManager.shared.commonFontSize, type: .둥근모)
        scoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreTitleLabel.snp.bottom).offset(5)
        }
    }
    func setupAvoiderImageView() {
        view.addSubview(avoiderImageView)
        
        avoiderImageView.image = UIImage(named: Asset.Avoider.getImage(n: UserDefaultManager.shared.settings["avoider"] ?? "avoider0", state: "right_stop"))
        
        
    }
}




