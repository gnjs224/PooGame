//
//  Color.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit
enum AssetsColor {
    case burgerColor
    case background
    case wine
    case sand
}
extension UIColor {
  static func appColor(_ name: AssetsColor) -> UIColor {
    switch name {
    case .burgerColor:
      return UIColor(red: 78.0/255.0, green: 37.0/255.0, blue: 20.0/255.0, alpha: 1)
    case .background:
      return UIColor(red: 244.0/255.0, green: 235.0/255.0, blue: 220.0/255.0, alpha: 1)
    case .wine:
        return UIColor(red: 198/255.0, green: 56.0/255.0, blue: 31.0/255.0, alpha: 1)
    case .sand:
        return UIColor(red: 208/255.0, green: 201/255.0, blue: 190/255.0, alpha: 1)
    }
  }
}

