//
//  SauceAmountString+CoreDataClass.swift
//  SandwichSaturation
//
//  Created by Danijela Vrzan on 2020-07-20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SauceAmountString)
public class SauceAmountString: NSManagedObject {
    var sauceAmount: SauceAmount {
        get {
            guard let sauceAmountString = self.sauceAmountString,
                let amount = SauceAmount(rawValue: sauceAmountString)
                else { return .none }
            return amount
        }
        set {
            self.sauceAmountString = newValue.rawValue
        }
    }
}
