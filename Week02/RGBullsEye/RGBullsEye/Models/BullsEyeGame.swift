//
//  RGBullsEyeGame.swift
//  RGBullsEye
//
//  Created by Danijela Vrzan on 2020-06-07.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

struct BullsEyeGame {
    
    var currentValue = RGB()
    var targetValue = RGB()
    var score = 0
    var round = 0
    
    mutating func calculatePoints() -> (String, String) {
        let difference = Int(100 * targetValue.difference(target: currentValue))
        var points = 100 - difference
        
        score += Int(points)

        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        let message = "You scored \(points) points"

        return (title, message)
    }
    
    mutating func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    mutating func startNewRound() {
        round += 1
        targetValue = RGB(r: Int.random(in: 1...255), g: Int.random(in: 1...255), b: Int.random(in: 1...255))
    }
    
}
