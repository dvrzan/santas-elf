//
//  HomeTableViewController.swift
//  CompatibilitySlider
//
//  Created by Danijela Vrzan on 2020-06-22.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    @IBOutlet weak var person1TextField: UITextField!
    @IBOutlet weak var person2TextField: UITextField!
    @IBOutlet weak var styleSwitch: UISwitch!
    @IBOutlet weak var checkCompatibilityButton: UIButton!
    
    var isDarkMode = false
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleSwitch.isOn = defaults.bool(forKey: "darkMode")
        styleSwitchValueChanged(styleSwitch)
        
        view.dismissKeyboardOnTapAnywhere(on: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        person1TextField.text = ""
        person2TextField.text = ""
    }
    
    //MARK: - Style Preference
    @IBAction func styleSwitchValueChanged(_ sender: UISwitch) {
        isDarkMode = sender.isOn
        updateStyle()
    }
    
    func updateStyle() {
        UIView.animate(withDuration: 0.4) {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = self.isDarkMode ? .dark : .light
            }
            self.defaults.set(self.isDarkMode, forKey: "darkMode")
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let person1TextField = person1TextField.text,
            let person2TextField = person2TextField.text else {
                return
        }
        let destVC = segue.destination as! CompatibilityViewController
        let person1Name = person1TextField
        let person2Name = person2TextField
        destVC.person1.name = person1Name
        destVC.person2.name = person2Name
    }
    
}
