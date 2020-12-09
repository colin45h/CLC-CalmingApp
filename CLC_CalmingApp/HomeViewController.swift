//
//  HomeViewController.swift
//  CLC_CalmingApp
//
//  Created by Tiger Coder on 12/9/20.
//  Copyright © 2020 clc.hehn. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    var timerDuration: Double = 0.0
    lazy var session = Session(timerDuration: timerDuration) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // User Functionality
    @IBAction func startSession(_ sender: UIButton) {
        
        timerDuration = timePicker.countDownDuration
        
        performSegue(withIdentifier: "sessionStart", sender: nil)
    }
    
    
    
    // Segue Functions + Changing View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sessionStart" {
            let nvc = segue.destination as! SessionViewController
            nvc.currentSession  = session
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        
    }
    
}
