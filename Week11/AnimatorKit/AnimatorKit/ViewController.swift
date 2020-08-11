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
    
    let swimAnimation = UIViewPropertyAnimator()
    let sharkAnimation = UIViewPropertyAnimator()
    let lowAirAnimation = UIViewPropertyAnimator()
    
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
                self.lowAirButton.center = self.menuIsOpen ? self.lowAirButtonCenter : self.mainMenuButton.center
                self.sharkButton.center = self.menuIsOpen ? self.sharkButtonCenter : self.mainMenuButton.center
                self.swimButton.center = self.menuIsOpen ? self.swimButtonCenter : self.mainMenuButton.center
        }, completion: {_ in
            if self.lowAirButton.currentImage == UIImage(named: "LowAirButton-ON") && !self.menuIsOpen {
                self.animateLowAirDiver1()
            }
            if self.swimButton.currentImage == UIImage(named: "SwimButton-ON") && !self.menuIsOpen {
                self.animateSwimDiver2ImageView()
            }
            if self.sharkButton.currentImage == UIImage(named: "SharkButton-ON") && !self.menuIsOpen {
                self.animateSharkImageView()
            }
        })
    }
    
    func collapseMainMenu() {
        lowAirButton.center = mainMenuButton.center
        swimButton.center = mainMenuButton.center
        sharkButton.center = mainMenuButton.center
    }
    
    func presentAlertView() {
        let originCenter = alertView.center
        alertView.layer.cornerRadius = 20
        UIView.animate(withDuration: 0.4, delay: 0, options: .autoreverse, animations: {
            self.alertView.alpha = 1
            self.alertView.center.y = 200
        }, completion: {_ in
            self.alertView.alpha = 0
            self.alertView.center = originCenter
        })
    }
    
    @IBAction func didTapLowAirButton(_ sender: UIButton) {
        changeButtonImage(sender, offImageName: "LowAirButton-OFF", onImageName: "LowAirButton-ON")
    }
    
    @IBAction func didTapSharkButton(_ sender: UIButton) {
        changeButtonImage(sender, offImageName: "SharkButton-OFF", onImageName: "SharkButton-ON")
    }
    
    @IBAction func didTapSwimButton(_ sender: UIButton) {
        changeButtonImage(sender, offImageName: "SwimButton-OFF", onImageName: "SwimButton-ON")
    }
    
    func animateSharkImageView() {
        let originalCenter = sharkImage.center
        view.layoutIfNeeded()
        // Create new keyframe animation
        UIView.animateKeyframes(withDuration: 7.0, delay: 0, animations: { [sharkImage = sharkImage.self!] in
            // Increase shark's width
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                sharkImage.frame.size.width += 200
            }
            // Move shark to right & off screen
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                sharkImage.alpha = 0
                sharkImage.center.x += 400
            }
            // Return shark's alpha to 1
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 0.1) {
                sharkImage.center = originalCenter
                sharkImage.alpha = 1
            }
        })
    }
    
    func animateLowAirDiver1() {
        let originalCenter = diver1Image.center
        view.layoutIfNeeded()
        // Create new keyframe animation
        UIView.animateKeyframes(withDuration: 7.0, delay: 0, animations: { [diver1Image = diver1Image.self!] in
            // Rotate diver & at the same time move to top and dissapear off screen
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.01) {
                diver1Image.backgroundColor = .systemRed
                diver1Image.layer.cornerRadius = 20
            }
            UIView.addKeyframe(withRelativeStartTime: 0.01, relativeDuration: 0.01) {
                diver1Image.backgroundColor = .clear
            }
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2) {
                diver1Image.transform = .init(rotationAngle: .pi/2)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.8) {
                diver1Image.center.y -= 700
            }
            // Return to starting position and remove all transformations
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 0.1) {
                diver1Image.center = originalCenter
                diver1Image.transform = .identity
            }
        })
    }
    
    func animateSwimDiver2ImageView() {
        let originalCenter = diver2Image.center
        view.layoutIfNeeded()
        // Create new keyframe animation
        UIView.animateKeyframes(withDuration: 7.0, delay: 0, animations: { [diver2Image = diver2Image.self!] in
            // Increase diver's width & move him off-screen to left
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0) {
                diver2Image.frame.size.width -= 700
            }
            // Return to original position
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 0.1) {
                diver2Image.center = originalCenter
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

