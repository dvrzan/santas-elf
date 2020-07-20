//
//  File.swift
//  SandwichSaturation
//
//  Created by Danijela Vrzan on 2020-07-20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataPersistence {
    func saveCoreData(name: String, sauceAmount: String, imageName: String)
    func loadCoreData()
}

class CoreDataPersistenceStore: CoreDataPersistence {
    func saveCoreData(name: String, sauceAmount: String, imageName: String) {
        
    }
    
    func saveCoreData() {
        
    }
    
    func loadCoreData() {
        
    }
    
    
}
