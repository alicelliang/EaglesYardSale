//
//  LSOETableViewController.swift
//  Eagles Yard Sale
//
//  Created by Alice Liang on 4/24/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import UIKit

class LSOETableViewController: UITableViewController {

    var selectedCell = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "LSOE"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return csonClassArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LSOEClassCell", for: indexPath)
        selectedCell = lsoeClassArray[indexPath.row]
        cell.textLabel?.text = selectedCell
        cell.layer.borderColor = UIColor(red: (148/255.0), green: (23/255.0), blue: (81/255.0), alpha: 1.0).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 25
        cell.clipsToBounds = true
        return cell
    }
    

}
