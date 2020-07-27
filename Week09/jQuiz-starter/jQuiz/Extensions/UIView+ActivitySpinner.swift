//
//  UIView+ActivitySpinner.swift
//  jQuiz
//
//  Created by Danijela Vrzan on 2020-07-24.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = .systemPurple
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner(after: Double = 2) {
        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            // then remove the spinner view controller
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
