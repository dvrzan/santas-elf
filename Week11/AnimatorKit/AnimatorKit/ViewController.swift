//
//  ViewController.swift
//  AnimatorKit
//
//  Created by Danijela Vrzan on 2020-08-10.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Menu Buttons
    @IBOutlet weak var mainMenuButton: UIButton!
    @IBOutlet weak var lowAirButton: UIButton!
    @IBOutlet weak var swimButton: UIButton!
    @IBOutlet weak var sharkButton: UIButton!
    
    //MARK: - Objects
    @IBOutlet weak var sharkImage: UIImageView!
    @IBOutlet weak var diver1Image: UIImageView!
    @IBOutlet weak var diver2Image: UIImageView!
    
    //MARK: - Properties
    private var menuIsOpen = false
    
    var lowAirButtonCenter: CGPoint!
    var sharkButtonCenter: CGPoint!
    var swimButtonCenter: CGPoint!
    
    //MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        collapseMainMenu()
    }
    
    func setUpView() {
        lowAirButtonCenter = lowAirButton.center
        sharkButtonCenter = sharkButton.center
        swimButtonCenter = swimButton.center
        
        lowAirButton.setImage(UIImage(named: "LowAirButton-OFF"), for: .normal)
        sharkButton.setImage(UIImage(named: "SharkButton-OFF"), for: .normal)
        swimButton.setImage(UIImage(named: "SwimButton-OFF"), for: .normal)
    }
    
    //MARK: - Main Menu Buttons Animation
    @IBAction func didTapMainMenuButton() {
        menuIsOpen.toggle()
        animateMainMenuButtons()
    }
    
    func animateMainMenuButtons() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveLinear,
            animations: {
                self.mainMenuButton.transform = .init(rotationAngle: self.menuIsOpen ? -.pi/4 : 0)
        })
        UIView.animate(withDuration: 0.3) {
            self.lowAirButton.center = self.menuIsOpen ? self.lowAirButtonCenter : self.mainMenuButton.center
            self.sharkButton.center = self.menuIsOpen ? self.sharkButtonCenter : self.mainMenuButton.center
            self.swimButton.center = self.menuIsOpen ? self.swimButtonCenter : self.mainMenuButton.center
        }
    }
    
    func collapseMainMenu() {
        lowAirButton.center = mainMenuButton.center
        swimButton.center = mainMenuButton.center
        sharkButton.center = mainMenuButton.center
    }
    
    @IBAction func didTapLowAirButton(_ sender: UIButton) {
        changeButtonImage(sender, offImageName: "LowAirButton-OFF", onImageName: "LowAirButton-ON")
    }
    
    @IBAction func didTapSharkButton(_ sender: UIButton) {
        changeButtonImage(sender, offImageName: "SharkButton-OFF", onImageName: "SharkButton-ON")
        animateSharkImageView(onTap: sender)
    }
    
    func animateSharkImageView(onTap: UIButton) {
        // Create new keyframe animation
        UIView.animateKeyframes(withDuration: 5.0, delay: 0, animations: { [sharkImage = sharkImage.self!] in
            // Increase shark's width
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                sharkImage.frame.size.width += 200
            }
            // Move shark to right & off screen
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 4.0) {
                sharkImage.center.x += 400
                sharkImage.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 5.0, relativeDuration: 0.2) {
                sharkImage.alpha = 1
            }
        })
    }
    
    @IBAction func didTapSwimButton(_ sender: UIButton) {
        changeButtonImage(sender, offImageName: "SwimButton-OFF", onImageName: "SwimButton-ON")
    }
    
    func changeButtonImage(_ sender: UIButton, offImageName: String, onImageName: String) {
        if sender.currentImage == UIImage(named: offImageName) {
            sender.setImage(UIImage(named: onImageName), for: .normal)
        } else {
            sender.setImage(UIImage(named: offImageName), for: .normal)
        }
    }

    
}

