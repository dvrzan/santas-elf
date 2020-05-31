//
//  ViewController.swift
//  ColorPicker
//
//  Created by Danijela Vrzan on 2020-05-29.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentRedHueValue = 0
    var currentGreenSaturationValue = 0
    var currentBlueBrightnessValue = 0
    
    @IBOutlet weak var backgroundColorView: UIView!
    
    @IBOutlet weak var redHueSlider: UISlider!
    @IBOutlet weak var greenSaturationSlider: UISlider!
    @IBOutlet weak var blueBrightnessSlider: UISlider!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var redHueLabel: UILabel!
    @IBOutlet weak var greenSaturationLabel: UILabel!
    @IBOutlet weak var blueBrightnessLabel: UILabel!
    
    @IBOutlet weak var redHueValueLabel: UILabel!
    @IBOutlet weak var greenSaturationValueLabel: UILabel!
    @IBOutlet weak var blueBrightnessValueLabel: UILabel!
    
    @IBOutlet weak var setColorButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSliderValueLabels()
        
    }
    
    //MARK: - Slider Value methods
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let redHueRoundedValue = redHueSlider.value.rounded()
        currentRedHueValue = Int(redHueRoundedValue)
        
        let greenSaturationRoundedValue = greenSaturationSlider.value.rounded()
        currentGreenSaturationValue = Int(greenSaturationRoundedValue)
        
        let blueBrightnessRoundedValue = blueBrightnessSlider.value.rounded()
        currentBlueBrightnessValue = Int(blueBrightnessRoundedValue)
        
        updateSliderValueLabels()
    }
    
    func updateSliderValueLabels() {
        redHueValueLabel.text = String(currentRedHueValue)
        greenSaturationValueLabel.text = String(currentGreenSaturationValue)
        blueBrightnessValueLabel.text = String(currentBlueBrightnessValue)
    }
    
    //MARK: - Alert Controller methods
    
    @IBAction func setColorButtonTapped(_ sender: UIButton) {
        showAlert()
    }
    
    func showAlert() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Set Color", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Set", style: .default, handler: {
            action in
            self.getColor()
            self.colorNameLabel.text = textField.text
        })
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            field.placeholder = "Enter new name for your color"
        }
        present(alert, animated: true, completion: nil)
    }
    
    func getColor() {
        let redHueRoundedValue = redHueSlider.value.rounded()
        let greenSaturationRoundedValue = greenSaturationSlider.value.rounded()
        let blueBrightnessRoundedValue = blueBrightnessSlider.value.rounded()
        
        let redHue = CGFloat(redHueRoundedValue / 255) //change 255 when dealing with hue value
        let greenSaturation = CGFloat(greenSaturationRoundedValue / 255)
        let blueBrightness = CGFloat(blueBrightnessRoundedValue / 255)
        
        backgroundColorView.backgroundColor = UIColor(red: redHue, green: greenSaturation, blue: blueBrightness, alpha: 1.0)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        backgroundColorView.backgroundColor = UIColor.systemBackground
        
        currentRedHueValue = 0
        currentBlueBrightnessValue = 0
        currentGreenSaturationValue = 0
        
        redHueSlider.value = Float(currentRedHueValue)
        greenSaturationSlider.value = Float(currentGreenSaturationValue)
        blueBrightnessSlider.value = Float(currentBlueBrightnessValue)
        
        updateSliderValueLabels()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
    }

}

