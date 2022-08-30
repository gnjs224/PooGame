//
//  ViewController.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit
import AVFoundation
extension UIViewController: AVAudioPlayerDelegate {
    func drawFrame(){
        let size = UIScreen.main.bounds.width / 10
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: Asset.Header.exit)?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpExitButton))
        if self is GameViewController {
            self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: (UserDefaultManager.shared.isSound ? Asset.Header.soundOn : Asset.Header.soundOff))?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpSoundButton)), animated: false)
        } else {
            self.navigationItem.setRightBarButtonItems([UIBarButtonItem(image: UIImage(named: (UserDefaultManager.shared.isSound ? Asset.Header.soundOn : Asset.Header.soundOff))?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpSoundButton)),UIBarButtonItem(image: UIImage(named: Asset.Header.setting)?.setSizeImage(height: size, width: size), style: .plain, target: self, action: #selector(touchUpSettingButton))], animated: false)
        }
        
        let backgroundImage = UIImageView()
        self.view.addSubview(backgroundImage)
        guard let imageName = UserDefaultManager.shared.settings["background"] else { return }
        backgroundImage.image = UIImage(named: Asset.Background.getImage(n: imageName))
        
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    @objc
    func touchUpExitButton() {
        
        // TODO: - 화면전환
        print(self)
        if self is GameViewController {
            self.navigationController?.popViewController(animated: false)
        }else if self is EndViewController {
            self.navigationController?.popToRootViewController(animated: false)
        } else{
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
        let vc = SettingViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
}
