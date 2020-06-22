//
//  UIView+DismissKeyboard.swift
//  CompatibilitySlider
//
//  Created by Danijela Vrzan on 2020-06-22.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension UIView {
    func dismissKeyboardOnTapAnywhere(on view: UIView) {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
