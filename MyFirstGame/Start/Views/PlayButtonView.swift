//
//  PlayButtonView.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit

class PlayButtonView: UIView {
    let playImageView = UIImageView()
    let playLabel = UILabel()
    var type: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        layer.cornerRadius = 60
        layer.shadowOffset = CGSize(width: -10, height: 10)
        layer.shadowOpacity = 1

    }
    convenience init(type: String) {
        self.init(frame: .zero)
        self.type = type
        setupPlayImageView()
        setupPlayLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupPlayImageView() {
        addSubview(playImageView)
        if let type = type {
            playImageView.image = UIImage(named: type)
        }
        
        
        playImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
            $0.width.height.equalToSuperview().multipliedBy(0.5)
        }
        
        
    }
    func setupPlayLabel() {
        addSubview(playLabel)
//        playLabel.text = "play!"
        if let type = type {
            playLabel.text = "\(type)!"
        }
        playLabel.font = UIFont.customFont(fontSize: UserDefaultManager.shared.commonFontSize, type: .둥근모)
        
        playLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(playImageView.snp.bottom).offset(10)
        }
    }
}
