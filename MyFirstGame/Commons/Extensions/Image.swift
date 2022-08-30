//
//  Image.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit
extension UIImage {
    func setSizeImage(height: CGFloat, width: CGFloat) -> UIImage {
        let newWidth = width
        let newHeight = height
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal) else { return UIImage(systemName: "trash")!}
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
