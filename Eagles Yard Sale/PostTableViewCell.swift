//
//  PostTableViewCell.swift
//  Eagles Yard Sale
//
//  Created by Alice Liang on 4/23/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!

    var post: Post! {
        didSet {
            userLabel.text = post.user
            nameLabel.text = post.bookTitle
            priceLabel.text = String(post.price)
//            for image in starImageCollection {
//                let image = UIImage(named: (starImage.tag < review.rating ? "star-filled": "star-empty"))
//                starImage.image = image
//            }
        }
    }
}
