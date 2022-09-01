//
//  SettingViewController.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/29.
//

import UIKit

class SettingViewController: UIViewController {
    let settingView = SettingView()
    weak var delegate: Setting?
    var backgroundIndex = 0
    var avoiderIndex = 0
    var coordinator: Coordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let existBackground = UserDefaultManager.shared.settings["background"], let existAvoider = UserDefaultManager.shared.settings["avoider"] {
            backgroundIndex = getIndex(existBackground)
            avoiderIndex = getIndex(existAvoider)
        }
        settingView.updateViews(backgroundIndex: backgroundIndex, avoiderIndex: avoiderIndex)
        setupSettingView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
       
    }
    func getIndex(_ sender: String) -> Int {
        let endChar = sender[sender.index(before: sender.endIndex)]
        if let index = Int(String(endChar)) {
            return index
        }
        return 0
    }

    func setupSettingView() {
        view.addSubview(settingView)
        
        settingView.exitButton.addTarget(self, action: #selector(touchUpDismissButton), for: .touchUpInside)
        
        [settingView.backgroundLeftButton, settingView.backgroundRightButton, settingView.avoiderLeftButton, settingView.avoiderRightButton].forEach {
            $0.addTarget(self, action: #selector(ChangeSetting(_:)), for: .touchUpInside)
        }
        
        settingView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
    }
    @objc
    func touchUpDismissButton() {
        // TODO: - 알러트
        UserDefaultManager.shared.settings = ["background": "background\(backgroundIndex)" ,"avoider": "avoider\(avoiderIndex)"]
        delegate?.updateSetting()
        
        dismiss(animated: false)
        
    }
    @objc
    func ChangeSetting(_ sender: UIButton) {
        switch sender {
        case settingView.backgroundLeftButton:
            backgroundIndex = backgroundIndex > 0 ? backgroundIndex - 1 : backgroundIndex
        case settingView.backgroundRightButton:
            backgroundIndex = backgroundIndex < 4 ? backgroundIndex + 1 : backgroundIndex
        case settingView.avoiderLeftButton:
            avoiderIndex = avoiderIndex > 0 ? avoiderIndex - 1 : avoiderIndex
        case settingView.avoiderRightButton:
            avoiderIndex = avoiderIndex < 2 ? avoiderIndex + 1 : avoiderIndex
        default:
            print("sender error")
        }
        settingView.updateViews(backgroundIndex: backgroundIndex, avoiderIndex: avoiderIndex)
    }
    
}
