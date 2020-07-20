//
//  SauceAmountString+CoreDataProperties.swift
//  SandwichSaturation
//
//  Created by Danijela Vrzan on 2020-07-20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


extension SauceAmountString {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SauceAmountString> {
        return NSFetchRequest<SauceAmountString>(entityName: "SauceAmountString")
    }

    @NSManaged public var sauceAmountString: String?
    @NSManaged public var sandwiches: NSSet?

}

// MARK: Generated accessors for sandwiches
extension SauceAmountString {

    @objc(addSandwichesObject:)
    @NSManaged public func addToSandwiches(_ value: Sandwich)

    @objc(removeSandwichesObject:)
    @NSManaged public func removeFromSandwiches(_ value: Sandwich)

    @objc(addSandwiches:)
    @NSManaged public func addToSandwiches(_ values: NSSet)

    @objc(removeSandwiches:)
    @NSManaged public func removeFromSandwiches(_ values: NSSet)

}
