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

    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func startSession(_ sender: UIButton) {
        
    }
    
    @IBAction func finishSession(_ sender: UIButton) {
        
        delegate?.finishedSessionPass(info: FinishedSession(date: Date(), duration: 0.0))
        
        performSegue(withIdentifier: "finishedSession", sender: self)
    }
}
