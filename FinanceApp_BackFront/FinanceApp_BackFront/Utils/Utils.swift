//
//  Utils.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 06/07/23.
//

import Foundation

class Utils {
    static func saveUserDefaults(value: Any, key: String) {
        return UserDefaults.standard.setValue(value, forKey: key)
    }
    
    static func removeUserDefaults(key: String) {
        return UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func getUserDefaults(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
}
