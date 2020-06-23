//
//  String+RegEx.swift
//  CompatibilitySlider
//
//  Created by Danijela Vrzan on 2020-06-22.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import Foundation

extension String {
    
    var isValidInput: Bool {
        let checkUserInputRegex = "[A-z]+"
        return NSPredicate(format: "SELF MATCHES %@", checkUserInputRegex).evaluate(with: self)
    }
    
}
