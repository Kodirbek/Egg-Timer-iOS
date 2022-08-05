//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var label: UILabel!
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720] // library = [key : value]
    var timer = Timer()
    var player : AVAudioPlayer! // use : (colon), not an equal sign
    var totalTime = 0
    var secondsPassed = 0
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()  // timer is invalidates each time user presses a button
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!  // here, title of the button(currentTitle) corresponds to the keys in 'eggTimes' library
        
        progressView.progress = 0.0  // progress view is restarted each time the button is pressed
        secondsPassed = 0 // seconds passed is equal to zero as the button is pressed
        label.text = hardness  // so that user can see which hardness has been selected
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            label.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
    
}
