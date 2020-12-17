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
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = Session(timerDuration: timerDuration, timerDoneListener: onTimerDone)
        
        finishButton.isHidden = true
        timeLabel.isHidden = true
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    // Called when start button pressed
    @IBAction func startSession(_ sender: UIButton) {
        session?.start()
        startButton.isHidden = true
        finishButton.isHidden = false
        timeLabel.isHidden = false
        
    }
    
    // Called when finish button pressed
    @IBAction func finishSession(_ sender: UIButton) {
        // this method throws because end mustn't be called before start
        try! session?.end()
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
}
