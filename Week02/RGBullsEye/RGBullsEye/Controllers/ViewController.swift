/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetTextLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let game = BullsEyeGame(currentValue: RGB(r: 0, g: 0, b: 0), targetValue: RGB(r: 0, g: 0, b: 0), score: 0, round: 0)
    var rgb = RGB()
    
    @IBAction func aSliderMoved(sender: UISlider) {
        let redRoundedValue = redSlider.value.rounded()
        let redValue = Int(redRoundedValue)
        
        let blueRoundedValue = blueSlider.value.rounded()
        let blueValue = Int(blueRoundedValue)
        
        let greenRoundedValue = greenSlider.value.rounded()
        let greenValue = Int(greenRoundedValue)
        
        game.currentValue = RGB(r: redValue, g: greenValue, b: blueValue)
        updateView()
    }
    
    @IBAction func showAlert(sender: AnyObject) {
        let title = game.calculatePoints().0
        let message = game.calculatePoints().1
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver(sender: AnyObject) {
        game.startNewGame()
        updateView()
    }
    
    func startNewRound() {
        game.startNewRound()
        redSlider.value = 128
        blueSlider.value = 128
        greenSlider.value = 128
        targetTextLabel.text = "Match this new color!"
        updateView()
    }
    
    func updateView() {
        redLabel.text = String(Int(redSlider.value))
        blueLabel.text = String(Int(blueSlider.value))
        greenLabel.text = String(Int(greenSlider.value))
        
        roundLabel.text = String(game.round)
        scoreLabel.text = String(game.score)
        
        targetLabel.backgroundColor = UIColor(rgbStruct: game.targetValue)
        guessLabel.backgroundColor = UIColor(rgbStruct: game.currentValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.startNewGame()
        updateView()
    }
}

