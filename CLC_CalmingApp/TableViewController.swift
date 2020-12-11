//
//  TableViewController.swift
//  CLC_CalmingApp
//
//  Created by Tiger Coder on 12/9/20.
//  Copyright © 2020 clc.hehn. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var sessionView: UITableView!
    
    var sessionList = [FinishedSession]()
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionView.delegate = self
        sessionView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let sesh = defaults.object(forKey: "daList") as? Data {
            sessionList = try! PropertyListDecoder().decode(Array<FinishedSession>.self, from: sesh)
        }
        
        sessionView.reloadData()
    }
    
    // Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sessionView.dequeueReusableCell(withIdentifier: "session")!
        cell.textLabel?.text = stringFromDate(sessionList[indexPath.row].date)
        cell.detailTextLabel?.text = secondsToMinutesSeconds(seconds: sessionList[indexPath.row].duration)
        return cell
    }
    
    
    // Background Functions
    func stringFromDate(_ date: Date) -> String {
        // Converts a Date object to a readable string
        let format = DateFormatter()
        format.dateFormat = "MMM/dd/yyyy"
        return format.string(from: date)
    }
    
    func secondsToMinutesSeconds(seconds: Double) -> String {
        // Turns the amount of seconds (Double) into a readable amount of time (String)
       let interval = seconds

       let formatter = DateComponentsFormatter()
       formatter.allowedUnits = [.hour, .minute, .second]
       formatter.unitsStyle = .abbreviated

       let formattedString = formatter.string(from: TimeInterval(interval))!
       return formattedString
    }
}
