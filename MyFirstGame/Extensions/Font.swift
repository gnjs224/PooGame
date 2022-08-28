//
//  Font.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit
extension UIFont {
    enum FontType: String {
        case 둥근모 = "NeoDunggeunmoPro-Regular"
    }
    static func customFont(fontSize: CGFloat, type: FontType) -> UIFont {
        guard let font = UIFont(name: type.rawValue, size: fontSize) else { return UIFont.systemFont(ofSize: 10)}
        return font
    }
}
