//
//  UIColor+BackgroundContrast.swift
//  ColorPicker
//
//  Created by Danijela Vrzan on 2020-06-01.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import UIKit

// Change label color to contrast background color for visibility
extension UIColor {
    var isDarkColor: Bool {
        var r, g, b, a : CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
        
        return luminance < 0.5
    }
}
