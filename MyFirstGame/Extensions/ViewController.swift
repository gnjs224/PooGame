//
//  ViewController.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit

extension UIViewController {
    
    func drawFrame(){
        let size = UIScreen.main.bounds.width / 10
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: Asset.Header.exit)?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpExitButton))
        if self is PlayViewController {
            self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: Asset.Header.sound)?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpSoundButton)), animated: false)
        } else {
            self.navigationItem.setRightBarButtonItems([UIBarButtonItem(image: UIImage(named: Asset.Header.sound)?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpSoundButton)),UIBarButtonItem(image: UIImage(named: Asset.Header.setting)?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpSettingButton))], animated: false)
        }
        
        let backgroundImage = UIImageView()
        self.view.addSubview(backgroundImage)
        guard let imageName = UserDefaultManager.shared.settings["background"] else { return }
        backgroundImage.image = UIImage(named: "background/\(imageName)")
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    @objc
    func touchUpExitButton() {
        // TODO: - 화면전환
        print(self)
        if self is PlayViewController {
            self.navigationController?.popViewController(animated: false)
        }else if self is EndViewController {
            self.navigationController?.popToRootViewController(animated: false)
        } else {
//            exit(0)
        }
    }
    @objc
    func touchUpSoundButton() {
        print("sound")
    }
    @objc
    func touchUpSettingButton() {
        print("setting")
    }

}
