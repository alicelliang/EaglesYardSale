//
//  TableViewCell.swift
//  Eagles Yard Sale
//
//  Created by Alice Liang on 4/24/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var contactInfo: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    
    var post: Post! {
        didSet {
            userLabel.text = post.seller
            nameLabel.text = post.bookTitle
            priceLabel.text = String(post.price)
            contactInfo.text = post.contactInfo
        }
        
    }
    var photo: Photo! {
        didSet {
            photoImage.image = photo.image
        }
    }
    
    
    
}
