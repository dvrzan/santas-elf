//
//  ImagePostModel.swift
//  Birdie
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

struct ImagePost: MediaPost {
    var textBody: String?
    var userName: String
    var timestamp: Date
    var image: UIImage
    
    var timeStampString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, HH:mm"
        
        return dateFormatter.string(from: timestamp)
    }
}


