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
    
    var maxRedHueSliderValue: Float = 255
    var maxGreenSaturationSliderValue: Float = 255
    var maxBlueBrightnessSliderValue: Float = 255
    
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
    
    //MARK: - Slider value methods
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        roundSliderValues()
        updateSliderValueLabels()
    }
    
    func roundSliderValues() {
        let redHueRoundedValue = redHueSlider.value.rounded()
        currentRedHueValue = Int(redHueRoundedValue)
        
        let greenSaturationRoundedValue = greenSaturationSlider.value.rounded()
        currentGreenSaturationValue = Int(greenSaturationRoundedValue)
        
        let blueBrightnessRoundedValue = blueBrightnessSlider.value.rounded()
        currentBlueBrightnessValue = Int(blueBrightnessRoundedValue)
    }
    
    func updateSliderValueLabels() {
        redHueValueLabel.text = String(currentRedHueValue)
        greenSaturationValueLabel.text = String(currentGreenSaturationValue)
        blueBrightnessValueLabel.text = String(currentBlueBrightnessValue)
    }
    
    //MARK: - Alert controller methods
    
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
    
    //MARK: - Background color methods
    
    func getColor() {
        let redHueRoundedValue = redHueSlider.value.rounded()
        let greenSaturationRoundedValue = greenSaturationSlider.value.rounded()
        let blueBrightnessRoundedValue = blueBrightnessSlider.value.rounded()
        
        let redHue = CGFloat(redHueRoundedValue / maxRedHueSliderValue)
        let greenSaturation = CGFloat(greenSaturationRoundedValue / maxGreenSaturationSliderValue)
        let blueBrightness = CGFloat(blueBrightnessRoundedValue / maxBlueBrightnessSliderValue)
        
        switch maxRedHueSliderValue {
        case 255:
            backgroundColorView.backgroundColor = UIColor(red: redHue, green: greenSaturation, blue: blueBrightness, alpha: 1.0)
        case 360:
            backgroundColorView.backgroundColor = UIColor(hue: redHue, saturation: greenSaturation, brightness: blueBrightness, alpha: 1.0)
        default:
            break
        }
    }
    
    //MARK: - Reset button methods
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        resetToDefaultValues()
        updateSliderValueLabels()
    }
    
    func resetToDefaultValues() {
        backgroundColorView.backgroundColor = UIColor.systemBackground
        
        currentRedHueValue = 0
        currentBlueBrightnessValue = 0
        currentGreenSaturationValue = 0
        
        redHueSlider.value = Float(currentRedHueValue)
        greenSaturationSlider.value = Float(currentGreenSaturationValue)
        blueBrightnessSlider.value = Float(currentBlueBrightnessValue)
    }
    
    //MARK: - Segmented control value methods
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        changeMode()
        resetToDefaultValues()
        updateSliderValueLabels()
    }
    
    func changeMode() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            redHueSlider.maximumValue = 255
            greenSaturationSlider.maximumValue = 255
            blueBrightnessSlider.maximumValue = 255
            
            redHueLabel.text = "Red"
            greenSaturationLabel.text = "Green"
            blueBrightnessLabel.text = "Blue"
        case 1:
            redHueSlider.maximumValue = 360
            greenSaturationSlider.maximumValue = 100
            blueBrightnessSlider.maximumValue = 100
            
            redHueLabel.text = "Hue"
            greenSaturationLabel.text = "Saturation"
            blueBrightnessLabel.text = "Brightness"
        default:
            break
        }
    }

}

