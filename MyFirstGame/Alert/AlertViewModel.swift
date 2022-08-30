//
//  AlertViewModel.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/31.
//

import Foundation
import UIKit

struct AlertViewModel {
    var discription: String
    var backgroundImage: UIImage
    
    init(discription: String) {
        self.discription = discription
        self.backgroundImage = UIImage()
        guard let img = UIImage(named: Asset.Background.settingBackground) else { return }
        self.backgroundImage = img
    }
}
