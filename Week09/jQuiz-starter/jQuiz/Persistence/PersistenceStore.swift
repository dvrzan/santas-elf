//
//  PersistenceStore.swift
//  jQuiz
//
//  Created by Danijela Vrzan on 2020-07-24.
//  Copyright © 2020 Jay Strawn. All rights reserved.
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
        userDefaults.object(forKey: key)
    }
}
