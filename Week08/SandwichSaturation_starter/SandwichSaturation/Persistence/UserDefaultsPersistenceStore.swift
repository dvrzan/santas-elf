//
//  PersistenceStore.swift
//  SandwichSaturation
//
//  Created by Danijela Vrzan on 2020-07-16.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation

protocol UserDefaultsPersistence {
    func saveData(value: Any, key: String)
    func loadData(key: String) -> Any?
}

class UserDefaultsPersistenceStore: UserDefaultsPersistence {
    
    var userDefaults = UserDefaults.standard
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func saveData(value: Any, key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func loadData(key: String) -> Any? {
        userDefaults.value(forKey: key)
    }
}
