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
    
    var swimAnimation = UIViewPropertyAnimator()
    var sharkAnimation = UIViewPropertyAnimator()
    var lowAirAnimation = UIViewPropertyAnimator()
    
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
        
        lowAirButton.setImage(UIImage(named: Const.Image.lowAirOFF), for: .normal)
        sharkButton.setImage(UIImage(named: Const.Image.sharkOFF), for: .normal)
        swimButton.setImage(UIImage(named: Const.Image.swimOFF), for: .normal)
        
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
            if !self.menuIsOpen {
                if self.lowAirButton.currentImage == UIImage(named: Const.Image.lowAirON) {
                    self.animateLowAirDiver1ImageView()
                }
                if self.swimButton.currentImage == UIImage(named: Const.Image.swimON){
                    self.animateSwimDiver2ImageView()
                }
                if self.sharkButton.currentImage == UIImage(named: Const.Image.sharkON){
                    self.animateSharkImageView()
                }
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
        changeButtonImage(sender, offImageName: Const.Image.lowAirOFF, onImageName: Const.Image.lowAirON)
    }
    
    @IBAction func didTapSharkButton(_ sender: UIButton) {
        changeButtonImage(sender, offImageName: Const.Image.sharkOFF, onImageName: Const.Image.sharkON)
    }
    
    @IBAction func didTapSwimButton(_ sender: UIButton) {
        changeButtonImage(sender, offImageName: Const.Image.swimOFF, onImageName: Const.Image.swimON)
    }
    
    func animateSharkImageView() {
        let originalCenter = sharkImage.center
        view.layoutIfNeeded()
        sharkAnimation = UIViewPropertyAnimator(duration: 5.0, curve: .easeIn)
        sharkAnimation.addAnimations {
            // Create new keyframe animation
            UIView.animateKeyframes(withDuration: 5.0, delay: 0, animations: { [sharkImage = self.sharkImage!] in
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
        sharkAnimation.startAnimation()
    }
    
    func animateLowAirDiver1ImageView() {
        let originalCenter = diver1Image.center
        view.layoutIfNeeded()
        lowAirAnimation = UIViewPropertyAnimator(duration: 5.0, curve: .easeIn)
        lowAirAnimation.addAnimations {
            // Create new keyframe animation
            UIView.animateKeyframes(withDuration: 7.0, delay: 0, animations: { [diver1Image = self.diver1Image!] in
                // Add background color red as simulated visual warning
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.01) {
                    diver1Image.backgroundColor = .systemRed
                    diver1Image.layer.cornerRadius = 20
                }
                // Remove background color
                UIView.addKeyframe(withRelativeStartTime: 0.01, relativeDuration: 0.01) {
                    diver1Image.backgroundColor = .clear
                }
                // Rotate diver 45 degrees
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2) {
                    diver1Image.transform = .init(rotationAngle: .pi/2)
                }
                // Move diver off screen at top
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
        lowAirAnimation.startAnimation()
    }
    
    func animateSwimDiver2ImageView() {
        let originalCenter = diver2Image.center
        view.layoutIfNeeded()
        swimAnimation = UIViewPropertyAnimator(duration: 5.0, curve: .easeIn)
        swimAnimation.addAnimations {
            // Create new keyframe animation
            UIView.animateKeyframes(withDuration: 7.0, delay: 0, animations: { [diver2Image = self.diver2Image!] in
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
        swimAnimation.startAnimation()
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

