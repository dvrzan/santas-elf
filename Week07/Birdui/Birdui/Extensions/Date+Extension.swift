//
//  Date+Extension.swift
//  Birdui
//
//  Created by Asif Ahmed Jesi on 10/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import Foundation

extension Date {
  
  var formatted: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
    return dateFormatter.string(from: self)
  }
  
}

