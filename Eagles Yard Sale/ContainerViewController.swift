//
//  ContainerViewController.swift
//  Eagles Yard Sale
//
//  Created by Alice Liang on 4/29/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.layer.cornerRadius = addButton.frame.size.width / 2 
    }
    

   

}
