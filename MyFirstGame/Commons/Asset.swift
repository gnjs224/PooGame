//
//  Asset.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/29.
//

import Foundation

struct Asset {
    /// 탭바 아이템
    struct Background {
        private static let `default`: String = "background"
        
        static let background0 = "\(`default`)/background0"
        static let background1 = "\(`default`)/background1"
        static let background2 = "\(`default`)/background2"
        static let background3 = "\(`default`)/background3"
        static let background4 = "\(`default`)/background4"
        
        static func getImage(n: String) -> String {
            return "\(`default`)/\(n)"
        }
    }
    
    struct Avoider {
        private static let `default`: String = "avoider"
        
        /// 현재 Avoider 이미지 뷰
        static func getImage(n: String, state: String, depth: String = "") -> String{
            return "\(Asset.Avoider.`default`)/\(n)_\(state)\(depth)-removebg-preview"
        }
    }
    
    /// 화면 상단
    struct Header {
        private static let `default`: String = "header"
        
        static let exit = "\(`default`)/exit"
        static let setting = "\(`default`)/setting"
        static let soundOn = "\(`default`)/soundOn"
        static let soundOff = "\(`default`)/soundOff"
    }
    
    /// 앱 요소에 관련한 부분
    struct ETC {
        private static let `default`: String = "etc"
        
        static let bottom = "\(`default`)/bottom"
        static let move = "\(`default`)/move"
        static let play = "\(`default`)/play"
        static let poo = "\(`default`)/poo"
        static let replay = "\(`default`)/replay"
        static let score = "\(`default`)/score"
    }
    
}

