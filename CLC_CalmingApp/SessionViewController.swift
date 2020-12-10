//
//  SessionViewController.swift
//  CLC_CalmingApp
//
//  Created by Tiger Coder on 12/9/20.
//  Copyright © 2020 clc.hehn. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {
    
    var timerDuration: Double!
    var session: Session?

    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = Session(timerDuration: timerDuration, timerDoneListener: onTimerDone)
    }

    // Called when start button pressed
    @IBAction func startSession(_ sender: UIButton) {
        session?.start()
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
