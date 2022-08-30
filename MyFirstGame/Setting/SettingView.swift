//
//  SettingView.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/30.
//

import UIKit

class SettingView: UIView {
    
    // MARK: - IBOutlets
    let settingLabel = UILabel()
    let backgroundImageView = UIImageView()
    let exitButton = UIButton()
    let backgroundTitleLabel = UILabel()
    let backgroundSelectedNameLabel = UILabel()
    let backgroundSelectedImageView = UIImageView()
    let avoiderTitleLabel = UILabel()
    let avoiderSelectedNameLabel = UILabel()
    let avoiderSelectedImageView = UIImageView()
    let middleLineView = UIView()
    let backgroundLeftButton = UIButton()
    let backgroundRightButton = UIButton()
    let avoiderLeftButton = UIButton()
    let avoiderRightButton = UIButton()
    let viewModel = SettingViewModel()
    // MARK: - Properties
    let size: CGFloat = 25
    let buttonSize: CGFloat = 40
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure() {
        setupBackgroundImageView()
        setupSelfView()
        setupSettingLabel()
        setupExitButton()
        
        setupBackgroundTitleLabel()
        setupBackgroundSelectedImageView()
        setupBackgroundSelectedNameLabel()
        
        setupMiddleLineView()
        
        setupAvoiderTitleLabel()
        setupAvoiderSelectedImageView()
        setupAvoiderSelectedNameLabel()
        
        setupBackgroundLeftButton()
        setupBackgroundRightButton()
        
        setupAvoiderLeftButton()
        setupAvoiderRightButton()
    }
    func updateViews(backgroundIndex: Int, avoiderIndex: Int) {
        backgroundSelectedImageView.image = UIImage(named: Asset.Background.getImage(n: backgroundIndex))
        backgroundSelectedNameLabel.text = viewModel.backgroundInfos[backgroundIndex].rawValue
        avoiderSelectedImageView.image = UIImage(named: Asset.Avoider.getImage(n: avoiderIndex))
        avoiderSelectedNameLabel.text = viewModel.avoiderInfos[avoiderIndex].rawValue
        
    }
    func setupSelfView() {
        layer.cornerRadius = 30
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
        backgroundColor = .systemPink
    }
    func setupSettingLabel() {
        addSubview(settingLabel)
        settingLabel.text = "Setting"
        settingLabel.font = UIFont.customFont(fontSize: UserDefaultManager.shared.commonFontSize - 10, type: .둥근모)
        settingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(size)
            $0.centerX.equalToSuperview()
        }
    }
    func setupBackgroundImageView() {
        addSubview(backgroundImageView)
        
        backgroundImageView.image = UIImage(named: Asset.Background.settingBackground)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        backgroundImageView.layer.cornerRadius = 30
        backgroundImageView.clipsToBounds = true
        
    }
    func setupExitButton() {
        addSubview(exitButton)
        exitButton.setImage(UIImage(named: Asset.Header.exit)?.setSizeImage(height: buttonSize - 5, width: size + 10), for: .normal)
        
        exitButton.snp.makeConstraints {
            $0.centerY.equalTo(settingLabel)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    func setupBackgroundTitleLabel() {
        addSubview(backgroundTitleLabel)
        backgroundTitleLabel.font = UIFont.customFont(fontSize: size, type: .둥근모)
        backgroundTitleLabel.text = "Background"
        backgroundTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(exitButton.snp.bottom).offset(30)
            
        }
    }
    
    func setupBackgroundSelectedImageView(){
        addSubview(backgroundSelectedImageView)
        backgroundSelectedImageView.layer.cornerRadius = 20
        backgroundSelectedImageView.clipsToBounds = true
        backgroundSelectedImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalToSuperview().multipliedBy(0.4)
            $0.top.equalTo(backgroundTitleLabel.snp.bottom).offset(10)
        }
    }
    
    func setupBackgroundSelectedNameLabel() {
        addSubview(backgroundSelectedNameLabel)
        backgroundSelectedNameLabel.font = UIFont.customFont(fontSize: size - 5, type: .둥근모)
        backgroundSelectedNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backgroundSelectedImageView.snp.bottom).offset(5)
        }
    }
    
    
    func setupMiddleLineView() {
        addSubview(middleLineView)
        
        middleLineView.backgroundColor = .black
        middleLineView.snp.makeConstraints {
            $0.top.equalTo(backgroundSelectedNameLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func setupAvoiderTitleLabel() {
        addSubview(avoiderTitleLabel)
        avoiderTitleLabel.text = "Avoider"
        
        avoiderTitleLabel.font = UIFont.customFont(fontSize: size, type: .둥근모)
        
        avoiderTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(middleLineView.snp.bottom).offset(15)
            
        }
    }
    
    func setupAvoiderSelectedImageView() {
        addSubview(avoiderSelectedImageView)
        avoiderSelectedImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalToSuperview().multipliedBy(0.25 * UIScreen.main.bounds.width / UIScreen.main.bounds.height)
            $0.top.equalTo(avoiderTitleLabel.snp.bottom).offset(10)
        }
    }
    func setupAvoiderSelectedNameLabel() {
        addSubview(avoiderSelectedNameLabel)
        
        avoiderSelectedNameLabel.font = UIFont.customFont(fontSize: size - 5, type: .둥근모)
        avoiderSelectedNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(avoiderSelectedImageView.snp.bottom).offset(5)
        }
    }
    
    func setupBackgroundLeftButton() {
        addSubview(backgroundLeftButton)
        
        backgroundLeftButton.setImage(UIImage(named: Asset.ETC.left)?.setSizeImage(height: buttonSize, width: buttonSize), for: .normal)
        backgroundLeftButton.snp.makeConstraints {
            $0.centerY.equalTo(backgroundSelectedImageView)
            $0.trailing.equalTo(backgroundSelectedImageView.snp.leading).offset(-40)
        }
    }
    func setupBackgroundRightButton() {
        addSubview(backgroundRightButton)
        
        backgroundRightButton.setImage(UIImage(named: Asset.ETC.right)?.setSizeImage(height: buttonSize, width: buttonSize), for: .normal)
        backgroundRightButton.snp.makeConstraints {
            $0.centerY.equalTo(backgroundSelectedImageView)
            $0.leading.equalTo(backgroundSelectedImageView.snp.trailing).offset(40)
        }
    }
    
    func setupAvoiderLeftButton() {
        addSubview(avoiderLeftButton)
        
        avoiderLeftButton.setImage(UIImage(named: Asset.ETC.left)?.setSizeImage(height: buttonSize, width: buttonSize), for: .normal)
        avoiderLeftButton.snp.makeConstraints {
            $0.centerY.equalTo(avoiderSelectedImageView)
            $0.trailing.equalTo(avoiderSelectedImageView.snp.leading).offset(-40)
        }
    }
    func setupAvoiderRightButton() {
        addSubview(avoiderRightButton)
        
        avoiderRightButton.setImage(UIImage(named: Asset.ETC.right)?.setSizeImage(height: buttonSize, width: buttonSize), for: .normal)
        avoiderRightButton.snp.makeConstraints {
            $0.centerY.equalTo(avoiderSelectedImageView)
            $0.leading.equalTo(avoiderSelectedImageView.snp.trailing).offset(40)
        }
    }
}
