//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

//import Foundation
import AVFoundation

class SoundManager: NSObject {
    
    static let shared = SoundManager()
    
    private var player: AVAudioPlayer?
    let defaults = UserDefaultsPersistence(userDefaults: UserDefaults.standard)
    
    var isSoundEnabled: Bool? {
        get {
            defaults.loadData(key: "sound") as? Bool
        }
    }
    
    func playSound() {
        do {
            guard let url = Bundle.main.url(forResource: "Jeopardy-theme-song", withExtension: ".mp3") else {
                return
            }
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            player?.numberOfLoops = -1
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func toggleSoundPreference() {
        if isSoundEnabled == true {
            playSound()
        } else {
            player?.stop()
        }
    }
    
}
