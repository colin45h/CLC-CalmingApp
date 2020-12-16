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
    var player = AVPlayer()
    
    var songList = [
        "https://drive.google.com/file/d/1xmdjFyKNMd-JvyAjT3DmILSsXvhOlncQ/view", // ocean
        "https://drive.google.com/file/d/1K4yQ54ImdqMl_O1-v1552XiSVLeubGIH/view", // lofi
        "https://drive.google.com/file/d/10ebhqEyf4XPtkNk2MlXseSg_oYPil1CV/view", // forest
        "https://drive.google.com/file/d/1_0Cz7xcayXeViUWE8eRcVVqalIkIO_Vf/view", // codefi
        "https://drive.google.com/file/d/1TdDdb6RX9cs23R1hmqft83WwazSvsvBb/view", // city
        "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/944801134&color=%23ff5500" // test
    ]
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = Session(timerDuration: timerDuration, timerDoneListener: onTimerDone)
        
        navigationController?.isNavigationBarHidden = true
        setPlayer()
    }
    
    // Called when start button pressed
    @IBAction func startSession(_ sender: UIButton) {
        player.play()
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
            
            self.player.pause()
            self.performSegue(withIdentifier: "finishedSession", sender: self)
        }))
        
        present(userFinished, animated: true)
        
    }
    
    func setPlayer() {
        
        let url = URL(string: songList[5])
        let playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
    }
}
