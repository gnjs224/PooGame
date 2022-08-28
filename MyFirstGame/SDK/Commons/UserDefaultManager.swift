//
//  UserDefaultManage.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/08/25.
//

import UIKit

class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    private init() { }
    
    @UserDefault(key: "settings", defaultValue: ["background": "background0", "character": "character0"])
    public var settings: Dictionary<String, String>
    
    @UserDefault(key: "commonFontSize", defaultValue: 40)
    public var commonFontSize: CGFloat
    
    @UserDefault(key: "isSound", defaultValue: true)
    public var isSound: Bool
    
    @UserDefault(key: "maxScore", defaultValue: 0)
    public var maxScore: Int
}

@propertyWrapper
struct UserDefault<T: Codable> {
    private let key: String
    private let defaultValue: T
    public let storage: UserDefaults

    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }

    var wrappedValue: T {
        get {
            guard let data = self.storage.object(forKey: key) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)

            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

