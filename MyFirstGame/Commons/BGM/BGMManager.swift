//
//  backgroundSoundManager.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/30.
//

import AVFoundation
import UIKit
//import UIKit
class BGMManager: NSObject, AVAudioPlayerDelegate {
    enum FileName: String {
        case start = "Start"
        case game = "Game"
        case end = "End"
    }
    
    
    static let shared = BGMManager()
    var audioPlayer: AVAudioPlayer?
    func playMusic(_ sender: UIViewController){
        var fileName: FileName = FileName.start
        if sender is GameViewController {
            fileName = FileName.game
        }else if sender is EndViewController {
            fileName = FileName.end
        }
        guard let filePath = Bundle.main.url(forResource: fileName.rawValue, withExtension: "mp3")
        else {
            print("not found sound file")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePath)
            audioPlayer?.prepareToPlay()
            audioPlayer?.numberOfLoops = -1
            if UserDefaultManager.shared.isSound {
                audioPlayer?.play()
            }
        } catch {
            print("audio file error")
        }

    }
    
}
