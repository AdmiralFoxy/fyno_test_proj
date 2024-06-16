//
//  UserDefault.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 16.06.2024.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct UserDefaultStorage {
    
    @UserDefault(key: "startUserWasSetup", defaultValue: false)
    static var startUserWasSetup: Bool
    
    @UserDefault(key: "allCountriesWasSaved", defaultValue: false)
    static var allCountriesWasSaved: Bool
    
}
