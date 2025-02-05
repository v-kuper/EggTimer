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
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLable: UILabel!
    
    let eggTimes = [
        "Soft": 60,
        "Medium": 120,
        "Hard": 240
    ]
    
    var totalTime = 0
    var secondsRemaining = 0
    var timer: Timer?
    var player: AVAudioPlayer!

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer?.invalidate()
        self.progressBar.progress = 0.0
                
        if let hardness = sender.currentTitle, let time = eggTimes[hardness] {
            totalTime = time
            secondsRemaining = time
            titleLable.text = hardness
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.updateCount()
            }
        } else {
            print("Ошибка: неизвестный уровень готовности")
        }
    }
    
    func playSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        }
    
    func updateCount() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            let progress = Float(totalTime - secondsRemaining) / Float(totalTime)
            progressBar.setProgress(progress, animated: true)
                    
            print("\(secondsRemaining) секунд осталось")
        } else {
            timer?.invalidate()
            titleLable.text = "Done!"
            playSound()
        }
    }
}
