//
//  PersistenceStore.swift
//  SandwichSaturation
//
//  Created by Danijela Vrzan on 2020-07-16.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation

protocol Persistence {
    func save(value: Any, key: String)
    func loadData(key: String) -> Any?
}

class UserDefaultsPersistence: Persistence {
    
    var userDefaults = UserDefaults.standard
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func save(value: Any, key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func loadData(key: String) -> Any? {
        userDefaults.value(forKey: key)
    }
}
