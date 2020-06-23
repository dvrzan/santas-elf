//
//  ViewController.swift
//  CompatibilitySlider
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class CompatibilityViewController: UIViewController {
    
    @IBOutlet weak var compatibilityItemLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var endGameImage: UIImageView!
    
    var compatibilityItems = ["Cats 🐱", "Dogs 🐶", "Star Trek 🛸", "Sushi 🍣", "Magic 🧙🏻‍♂️", "Chocolate 🍫"] // Add more!
    var currentItemIndex = 0
    
    var person1 = Person(id: 1, name: "Person 1", items: [:])
    var person2 = Person(id: 2, name: "Person 2", items: [:])
    var currentPerson: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPerson = person1
        checkIfPersonNameIsEmpty()
        questionLabel.text = person1.name + " how do you feel about..."
        updateLabels()
    }
    
    func checkIfPersonNameIsEmpty() {
        if currentPerson?.name == "" {
            currentPerson?.name = "Person \(currentPerson?.id ?? 0)"
        }
    }
    
    func checkIfPerson2NameIsEmpty() {
        if currentPerson?.name == "" {
            person2.name = "Person 2"
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        //print(sender.value)
    }
    
    func updateLabels() {
        switch currentItemIndex {
        case 0...compatibilityItems.count - 1:
            compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
        case compatibilityItems.count:
            currentItemIndex = 0
            currentPerson = person2
            checkIfPersonNameIsEmpty()
            questionLabel.text = person2.name + " how do you feel about..."
            compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
        default:
            break
        }
    }
    
    @IBAction func didPressNextItemButton(_ sender: Any) {
        let currentItem = compatibilityItems[currentItemIndex]
        currentPerson?.items.updateValue(slider.value, forKey: currentItem)
        if currentItemIndex == compatibilityItems.count - 1 && currentPerson?.id == person2.id {
            endGameImage.isHidden = false
            showAlert()
        }
        currentItemIndex += 1
        updateLabels()
    }
    
    func calculateCompatibility() -> String {
        // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
        var percentagesForAllItems: [Double] = []
        
        for (key, person1Rating) in person1.items {
            let person2Rating = person2.items[key] ?? 0
            let difference = abs(person1Rating - person2Rating)
            percentagesForAllItems.append(Double(difference))
        }
        
        let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
        let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
        print(matchPercentage, "%")
        let matchString = 100 - (matchPercentage * 100).rounded()
        return "\(matchString)%"
    }
    
    func showAlert() {
        let message = calculateCompatibility()
        let alert = UIAlertController(title: "\(person1.name) & \(person2.name)", message: "You are \(message) compatible!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startAgain()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func startAgain() {
        dismiss(animated: true, completion: nil)
    }
    
}

