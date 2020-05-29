//
//  ViewController.swift
//  ColorPicker
//
//  Created by Danijela Vrzan on 2020-05-29.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func setColorButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    }
    

}

