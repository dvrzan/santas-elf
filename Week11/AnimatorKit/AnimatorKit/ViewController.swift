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
    @IBOutlet weak var alertView: UIView!
    
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
        
        alertView.alpha = 0
    }
    
    //MARK: - Main Menu Buttons animation methods
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
    
    func presentAlertView() {
        alertView.layer.cornerRadius = 20
        UIView.animate(withDuration: 0.6, delay: 0, options: .autoreverse, animations: {
            self.alertView.center.y = 200
            self.alertView.alpha = 1
        }, completion: {_ in
            self.alertView.alpha = 0
        })
    }
    
    @IBAction func didTapLowAirButton(_ sender: UIButton) {
        changeButtonImage(sender, offImageName: "LowAirButton-OFF", onImageName: "LowAirButton-ON")
        animateLowAirDiver1()
    }
    
    @IBAction func didTapSharkButton(_ sender: UIButton) {
        changeButtonImage(sender, offImageName: "SharkButton-OFF", onImageName: "SharkButton-ON")
        if sender.currentImage == UIImage(named: "SharkButton-ON") {
            animateSharkImageView()
        }
    }
    
    @IBAction func didTapSwimButton(_ sender: UIButton) {
        changeButtonImage(sender, offImageName: "SwimButton-OFF", onImageName: "SwimButton-ON")
        animateSwimDiver2ImageView()
    }
    
    func animateSharkImageView() {
        // Create new keyframe animation
        UIView.animateKeyframes(withDuration: 5.0, delay: 0, animations: { [sharkImage = sharkImage.self!] in
            // Increase shark's width
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                sharkImage.frame.size.width += 200
            }
            // Move shark to right & off screen
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 4.0) {
                sharkImage.alpha = 0
                sharkImage.center.x += 400
            }
            // Return shark's alpha to 1
            UIView.addKeyframe(withRelativeStartTime: 5.0, relativeDuration: 0.2) {
                sharkImage.alpha = 1
            }
        })
    }
    
    func animateLowAirDiver1() {
        // Create new keyframe animation
        UIView.animateKeyframes(withDuration: 5.0, delay: 0, animations: { [diver1Image = diver1Image.self!] in
            // Rotate diver & at the same time move to top and dissapear off screen
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 2.0) {
                diver1Image.transform = .init(rotationAngle: .pi/2)
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 5.0) {
                diver1Image.center.y -= 700
            }
        })
    }
    
    func animateSwimDiver2ImageView() {
        // Create new keyframe animation
        UIView.animateKeyframes(withDuration: 5.0, delay: 0, animations: { [diver2Image = diver2Image.self!] in
            // Increase diver's width & move him off-screen to left
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 5.0) {
                diver2Image.frame.size.width -= 650
            }
        })
    }
    
    //MARK: - Utility methods
    func changeButtonImage(_ sender: UIButton, offImageName: String, onImageName: String) {
        if sender.currentImage == UIImage(named: offImageName) {
            sender.setImage(UIImage(named: onImageName), for: .normal)
            presentAlertView()
        } else {
            sender.setImage(UIImage(named: offImageName), for: .normal)
        }
    }

    
}

