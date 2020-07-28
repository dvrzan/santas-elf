//
//  ImageCache.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/19/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

var imageCache = NSCache<NSString,AnyObject>()

extension UIImageView {
    func loadImage(urlString: String) {
        if let cacheImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Could not download image: ", error)
                return
            }
            guard let data = data else {
                return
            }
            let image = UIImage(data: data)
            imageCache.setObject(image!, forKey: urlString as NSString)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    .resume()
    }
}
