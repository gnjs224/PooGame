//
//  SettingInfo.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/31.
//

import Foundation
enum SettingType: String {
    case background0 = "리스항구"
    case background1 = "헤네시스"
    case background2 = "페리온"
    case background3 = "슬리피우드"
    case background4 = "엘리니아"
    case avoider0 = "도적"
    case avoider1 = "전사"
    case avoider2 = "궁수"
}
struct SettingViewModel {
    let backgroundInfos: [SettingType] = [SettingType.background0, SettingType.background1, SettingType.background2, SettingType.background3, SettingType.background4]
    let avoiderInfos: [SettingType] = [SettingType.avoider0, SettingType.avoider1, SettingType.avoider2]
}

