//
//  ViewController.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit
import AVFoundation
extension UIViewController: AVAudioPlayerDelegate, Setting {
    func drawFrame(_ sender: UIImageView){
        let size = UIScreen.main.bounds.width / 10
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: Asset.Header.exit)?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpExitButton))
        if !(self is StartViewController) {
            self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: (UserDefaultManager.shared.isSound ? Asset.Header.soundOn : Asset.Header.soundOff))?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpSoundButton)), animated: false)
        } else {
            self.navigationItem.setRightBarButtonItems([UIBarButtonItem(image: UIImage(named: (UserDefaultManager.shared.isSound ? Asset.Header.soundOn : Asset.Header.soundOff))?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpSoundButton)),UIBarButtonItem(image: UIImage(named: Asset.Header.setting)?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpSettingButton))], animated: false)
        }
        
        self.view.addSubview(sender)
        guard let imageName = UserDefaultManager.shared.settings["background"] else { return }
        sender.image = UIImage(named: Asset.Background.getImage(n: imageName))
  
        sender.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    func updateSetting() {

        if let a = self as? StartViewController {
            a.avoiderImageView.image = UIImage(named: Asset.Avoider.getImage(n: UserDefaultManager.shared.settings["avoider"] ?? "avodier0", state: "right_stop"))
            a.backgroundImage.image = UIImage(named: Asset.Background.getImage(n: UserDefaultManager.shared.settings["background"] ?? "background0"))
        }
    }
    @objc
    func touchUpExitButton() {
        
        // TODO: - 화면전환
        
        if let startVC = self as? StartViewController {
            if let coordinate = startVC.coordinator as? StartCoordinator {
                coordinate.appExit()
            }
        }
        if let gameVC = self as? GameViewController {
            if let coordinate = gameVC.coordinator as? GameCoordinator {
                coordinate.popToStartViewController()
                gameVC.moveState = .leftDie
            }
        }
        if let endVC = self as? EndViewController {
            if let coordinate = endVC.coordinator as? EndCoordinator {
                coordinate.popToStartViewController()
            }
        }
    }
    @objc
    func touchUpSoundButton() {
        let size = UIScreen.main.bounds.width / 10
        
        if UserDefaultManager.shared.isSound {
            UserDefaultManager.shared.isSound = false
            BGMManager.shared.audioPlayer?.stop()
            navigationItem.rightBarButtonItems?[0].image = UIImage(named: Asset.Header.soundOff)?.setSizeImage(height: size, width: size)
        } else {
            UserDefaultManager.shared.isSound = true
            BGMManager.shared.audioPlayer?.play()
            navigationItem.rightBarButtonItems?[0].image = UIImage(named: Asset.Header.soundOn)?.setSizeImage(height: size, width: size)
        }
    }
    @objc
    func touchUpSettingButton() {
        if let startVC = self as? StartViewController {
            if let coordinate = startVC.coordinator as? StartCoordinator {
                coordinate.showSettingViewController()
            }
        }
    }
    
}
