//
//  CSOMTableViewController.swift
//  Eagles Yard Sale
//
//  Created by Alice Liang on 4/24/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import UIKit

class CSOMTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 50)
        
//        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10.0).isActive = true
//        tableView.rightAnchor.constraint
        self.navigationItem.title = "CSOM"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return csomClassArray.count
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CSOMClassCell", for: indexPath)
        cell.textLabel?.text = csomClassArray[indexPath.section]
        cell.layer.borderColor = UIColor(red: (148/255.0), green: (23/255.0), blue: (81/255.0), alpha: 1.0).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 25
        cell.clipsToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
}
