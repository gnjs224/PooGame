//
//  Poo.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/27.
//

import UIKit
struct Poo {
    let pooImageView: UIImageView
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat
    var speed: CGFloat
    init(x: CGFloat, y: CGFloat, speed: CGFloat) {
        self.x = x
        self.y = y
        self.width = 30
        self.height = 30
        self.speed = speed
        pooImageView = UIImageView(frame: CGRect(x: x, y: y, width: self.width, height: self.height))
        pooImageView.image = UIImage(named: Asset.ETC.poo)
    }
}
