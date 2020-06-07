//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    let game = BullsEyeGame(currentValue: 0, targetValue: 0, score: 0, round: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let roundedValue = slider.value.rounded()
        game.currentValue = Int(roundedValue)
        startNewGame()
    }
    
    @IBAction func showAlert() {
        let title = game.calculatePoints().0
        let message = game.calculatePoints().1
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        game.currentValue = Int(roundedValue)
    }
    
    func startNewRound() {
        game.startNewRound()
        game.currentValue = 50
        updateViewInfo()
    }
    
    func updateViewInfo() {
        targetLabel.text = String(game.targetValue)
        scoreLabel.text = String(game.score)
        roundLabel.text = String(game.round)
        slider.value = Float(game.currentValue)
    }
    
    @IBAction func startNewGame() {
        game.startNewGame()
        updateViewInfo()
    }
    
}



