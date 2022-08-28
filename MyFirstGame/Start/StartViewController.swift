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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawFrame()
        setupPlayButtonView()
        setupTitleLabel()
        setupScoreTitleLabel()
        setupScoreLabel()
        setupCharacter()
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
        navigationController?.pushViewController(PlayViewController(), animated: false)
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
        scoreLabel.text = "\(UserDefaultManager.shared.maxScore)"
        scoreLabel.font = UIFont.customFont(fontSize: UserDefaultManager.shared.commonFontSize, type: .둥근모)
        scoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreTitleLabel.snp.bottom).offset(5)
        }
    }
    func setupCharacter() {
        
    }
    
    
}

