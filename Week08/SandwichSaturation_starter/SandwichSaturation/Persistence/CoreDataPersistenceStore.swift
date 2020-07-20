//
//  File.swift
//  SandwichSaturation
//
//  Created by Danijela Vrzan on 2020-07-20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataPersistence {
    func saveData(_: SandwichData) -> Sandwich
    func loadData() -> [Sandwich]
}

class CoreDataPersistenceStore: CoreDataPersistence {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var query = ""
    
    func saveData(_ sandwich: SandwichData) -> Sandwich {
        let sandwichData = Sandwich(entity: Sandwich.entity(), insertInto: context)
        sandwichData.name = sandwich.name
        sandwichData.sauceAmount = SauceAmountString(entity: SauceAmountString.entity(), insertInto: context)
        sandwichData.sauceAmount?.sauceAmountString = sandwich.sauceAmount.rawValue
        sandwichData.image = sandwich.imageName
        
        appDelegate.saveContext()
        
        return sandwichData
    }
    
    func loadData() -> [Sandwich] {
        let request: NSFetchRequest<Sandwich> = Sandwich.fetchRequest()
        var sandwiches = [Sandwich]()
        if !query.isEmpty {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", query)
        }
        let sort = NSSortDescriptor(key: #keyPath(Sandwich.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        do {
            sandwiches = try context.fetch(request)
        } catch let error {
            print("Error fetching items from context, \(error)")
        }
        return sandwiches
    }
    
}
