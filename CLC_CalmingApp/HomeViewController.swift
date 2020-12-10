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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func viewDidAppear() {
        timePicker.countDownDuration = 300
    }

    // User Functionality
    @IBAction func startSession(_ sender: UIButton) {
        performSegue(withIdentifier: "sessionStart", sender: nil)
    }
    
    
    // Segue Functions + Changing View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sessionStart" {
            let sessionViewController = segue.destination as! SessionViewController
            sessionViewController.timerDuration = timePicker.countDownDuration
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        
    }
    
}
