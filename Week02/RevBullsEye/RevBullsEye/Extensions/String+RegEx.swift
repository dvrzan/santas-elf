//
//  String+RegEx.swift
//  RevBullsEye
//
//  Created by Danijela Vrzan on 2020-06-08.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import Foundation

extension String {
    
    var isValidInput: Bool {
        let checkUserInputRegex = "^([1-9][0-9]?|100)$"
        
        return NSPredicate(format: "SELF MATCHES %@", checkUserInputRegex).evaluate(with: self)
    }
    
}
