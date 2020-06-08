//
//  ViewController.swift
//  RevBullsEye
//
//  Created by Danijela Vrzan on 2020-06-08.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentGuessTextField: UITextField!
    @IBOutlet weak var targetValueSlider: UISlider!
    @IBOutlet weak var hitMeButton: UIButton! {
        didSet {
            hitMeButton.layer.cornerRadius = 17
        }
    }
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var hintBubbleImageView: UIImageView!
    
    var currentValue: Int {
        if let currentValue = Int(currentGuessTextField.text!) {
            game.currentValue = currentValue
            return currentValue
        }
        return 0
    }
    
    var quickDiff: Int {
        return abs(game.targetValue - currentValue)
    }
    
    let game = BullsEyeGame(currentValue: 0, targetValue: 0, score: 0, round: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentGuessTextField.delegate = self
        
        hintBubbleImageView.tintColor = .white
        hitMeButton.isEnabled = false
        targetValueSlider.isUserInteractionEnabled = false
        
        currentValueToInt()
        game.startNewGame()
        updateViewInfo()
        
        dismissKeyboardOnTapAnywhere()
    }
    
    func showAlert() {
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
    
    func startNewRound() {
        game.startNewRound()
        if let currentValue = Int(currentGuessTextField.text!) {
            game.currentValue = currentValue
        }
        updateViewInfo()
        hitMeButton.isEnabled = false
    }
    
    func updateViewInfo() {
        roundLabel.text = String(game.round)
        scoreLabel.text = String(game.score)
        targetValueSlider.value = Float(game.targetValue)
    }
    
    @IBAction func targetValueSliderValueChanged(_ sender: Any) {
        currentValueToInt()
    }
    
    @IBAction func didTapNewGameButton(_ sender: UIButton) {
        game.startNewGame()
        updateViewInfo()
    }
    
    @IBAction func currentGuessTextFieldEditingDidChange(_ sender: UITextField) {
        changeHintBubbleTintColor()
        if let userInput = sender.text, userInput.isValidInput == false {
            return hitMeButton.isEnabled = false
        } else {
            return hitMeButton.isEnabled = true
        }
    }

    @IBAction func didTapHitMeButton(_ sender: UIButton) {
        if let currentValue = Int(currentGuessTextField.text!) {
            game.currentValue = currentValue
        }
        showAlert()
    }
    
    func dismissKeyboardOnTapAnywhere() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func currentValueToInt() {
        let roundedValue = targetValueSlider.value.rounded()
        game.currentValue = Int(roundedValue)
    }
    
    func changeHintBubbleTintColor() {
        hintBubbleImageView.tintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeHintBubbleTintColor()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        currentGuessTextField.text = ""
        hintBubbleImageView.tintColor = .white
    }
    
}
