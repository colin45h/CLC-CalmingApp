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
    @IBOutlet weak var tealBackground: UIImageView!
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.object(forKey: "daList") != nil {
        }
        else {
            defaults.set([FinishedSession](), forKey: "daList")
        }
        
        tealBackground.frame = UIScreen.main.nativeBounds
        
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
