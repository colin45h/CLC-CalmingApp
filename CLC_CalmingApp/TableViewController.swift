//
//  TableViewController.swift
//  CLC_CalmingApp
//
//  Created by Tiger Coder on 12/9/20.
//  Copyright © 2020 clc.hehn. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FinishSessionDelegate {
    
    @IBOutlet weak var sessionView: UITableView!
    
    var sessionList = [FinishedSession]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sessionView.dequeueReusableCell(withIdentifier: "session")!
        cell.textLabel?.text = stringFromDate(sessionList[indexPath.row].date) 
        return cell
    }
    
    
    // Background Functions
    func stringFromDate(_ date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "dd MMM yyyy HH:mm"
        return format.string(from: date)
    }
    
    func finishedSessionPass(info: FinishedSession) {
        sessionList.append(info)
    }
}
