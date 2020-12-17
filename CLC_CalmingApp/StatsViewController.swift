//
//  StatsViewController.swift
//  CLC_CalmingApp
//
//  Created by Tiger Coder on 12/16/20.
//  Copyright © 2020 clc.hehn. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var statsView: UITableView!
    
    var sessionList = [FinishedSession]()
    var stats: [(title: String, value: String)] = [("Number of Sessions", "0"), ("Total Session Time", "0"), ("Average Session Length", "0")]
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statsView.delegate = self
        statsView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
        statsView.reloadData()
    }
    
    // Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statsView.dequeueReusableCell(withIdentifier: "stat")!
        cell.textLabel?.text = stats[indexPath.row].title
        cell.detailTextLabel?.text = String(stats[indexPath.row].value)
        return cell
    }
    
    func loadData() {
        if let sesh = defaults.object(forKey: "daList") as? Data {
            sessionList = try! PropertyListDecoder().decode(Array<FinishedSession>.self, from: sesh)
        }
        
        var totalDuration = 0.0
        
        for session in sessionList {
            totalDuration += session.duration
        }
        
        stats[0].value = String(sessionList.count)
        stats[1].value = String(Int(totalDuration))
        stats[2].value = String(Int(totalDuration / Double(sessionList.count)))
    }
}
