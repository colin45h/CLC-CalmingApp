//
//  SessionViewController.swift
//  CLC_CalmingApp
//
//  Created by Tiger Coder on 12/9/20.
//  Copyright © 2020 clc.hehn. All rights reserved.
//

import UIKit
import AVFoundation

class SessionViewController: UIViewController {
    
    var timerDuration: Double!
    var session: Session?
    
    var count: Int = 0
    var continuar = true
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var purpleBackground: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = Session(timerDuration: timerDuration, timerDoneListener: onTimerDone)
        
        finishButton.isHidden = true
        timeLabel.isHidden = true
        
        navigationController?.isNavigationBarHidden = true
        
        count = Int(timerDuration)
    }
    
    // Called when start button pressed
    @IBAction func startSession(_ sender: UIButton) {
        session?.start()
        startButton.isHidden = true
        finishButton.isHidden = false
        timeLabel.isHidden = false
        
        timeLabel.text = timeFormatted(count)
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    @objc func update() {
        if(count > 0 && continuar == true) {
            timeLabel.text = timeFormatted(count)
            count = count - 1
        }
    }
    
    // Called when finish button pressed
    @IBAction func finishSession(_ sender: UIButton) {
        // this method throws because end mustn't be called before start
        try! session?.end()
        
        continuar = false
        doSegue()
    }
    
    // Called when timer finished but not when finished button pressed
    func onTimerDone() {
        doSegue()
    }
    
    func doSegue() {
        // save throws because it can't get a finished session if session was never finished
        
        let userFinished = UIAlertController(title: "Finished!", message: "You finished your session!", preferredStyle: .alert)
        userFinished.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            try! self.session?.save()
            
            self.performSegue(withIdentifier: "finishedSession", sender: self)
        }))
        
        present(userFinished, animated: true)
        
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
