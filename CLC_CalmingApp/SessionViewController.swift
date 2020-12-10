//
//  SessionViewController.swift
//  CLC_CalmingApp
//
//  Created by Tiger Coder on 12/9/20.
//  Copyright © 2020 clc.hehn. All rights reserved.
//

import UIKit

protocol FinishSessionDelegate: AnyObject {
    func finishedSessionPass(info: FinishedSession)
}

class SessionViewController: UIViewController {
    
    var delegate: FinishSessionDelegate? = nil
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
    }

    // Called when timer finished but not when finished button pressed
    func onTimerDone() {

    }

    func doSegue() {
        // getFinishedSession throws because it can't get a finished session is if session was never finished
        try! delegate?.finishedSessionPass(info: (session?.getFinishedSession())!)
        performSegue(withIdentifier: "finishedSession", sender: self)
    }
}
