//
//  EndViewController.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit

class EndViewController: UIViewController {
    let backgroundImageView = UIImageView()
    let scoreTitleLabel = UILabel()
    let scoreLabel = UILabel()
    let scoreImageView = UIImageView()
    let replayButtonView = PlayButtonView(type: "replay")
    var avoiderImageView = UIImageView()
    var score = 0
    
    override func viewDidLoad() {
        avoiderImageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width / 2, y: self.view.safeAreaLayoutGuide.layoutFrame.maxY - 84, width: 40, height: 40))
        super.viewDidLoad()
        drawFrame(backgroundImageView)
        if score > UserDefaultManager.shared.maxScore {
            UserDefaultManager.shared.maxScore = score
        }
        setupScoreTitleLabel()
        setupScoreLabel()
        setupScoreImageView()
        setupReplayButtonView()
        setupAvoiderImageView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        BGMManager.shared.playMusic(self)
    }
    func setupScoreTitleLabel() {
        view.addSubview(scoreTitleLabel)
        scoreTitleLabel.text = "SCORE"
        scoreTitleLabel.font = UIFont.customFont(fontSize: UserDefaultManager.shared.commonFontSize, type: .둥근모)
        scoreTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
    }
    func setupScoreLabel() {
        view.addSubview(scoreLabel)
        
        scoreLabel.text = "\(score)"
        scoreLabel.font = UIFont.customFont(fontSize: UserDefaultManager.shared.commonFontSize, type: .둥근모)
        
        scoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreTitleLabel.snp.bottom).offset(20)
        }
    }
    func setupScoreImageView() {
        view.addSubview(scoreImageView)
        
        scoreImageView.image = UIImage(named: Asset.ETC.score)?.setSizeImage(height: UIScreen.main.bounds.width * 0.4, width: UIScreen.main.bounds.width * 0.4)
        scoreImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreLabel.snp.bottom).offset(40)
        }
    }
    func setupAvoiderImageView() {
        view.addSubview(avoiderImageView)
        
        avoiderImageView.image = UIImage(named: Asset.Avoider.getImage(n: UserDefaultManager.shared.settings["avoider"] ?? "avoider0", state: "right_stop"))
        
    }
    func setupReplayButtonView() {
        view.addSubview(replayButtonView)
        
        replayButtonView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreImageView.snp.bottom).offset(60)
            $0.width.height.equalTo(UIScreen.main.bounds.width * 0.5)
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(touchUpReplayButtonView))
        replayButtonView.addGestureRecognizer(gesture)
        replayButtonView.isUserInteractionEnabled = true
    }
    
    @objc
    func touchUpReplayButtonView() {
        // TODO: - 화면 전환
        self.navigationController?.pushViewController(GameViewController(), animated: false)
//
//        self.navigationController?.popToRootViewController(animated: false)
//            }
    }

}
