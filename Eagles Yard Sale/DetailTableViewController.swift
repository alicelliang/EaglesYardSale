//
//  DetailTableViewController.swift
//  Eagles Yard Sale
//
//  Created by Alice Liang on 4/28/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var posts: Posts!
    var photos: Photos!
//    var photo: Photo!
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        if post == nil {
            post = Post()
        }
//        if photo == nil {
//            photo = Photo()
//        }
        
        photos = Photos()
        posts = Posts()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appearing")
        posts.loadData() {
            print("Loading posts")
            self.tableView.reloadData()
            for post in self.posts.postArray {
                // post.documentID
                self.photos.loadData(post: post) {
                    self.tableView.reloadData()
                    print("Loading photos for " + post.documentID)
                    print("number of photos: \(self.photos.photoArray.count)")
                }
            }
            
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.postArray.count
            //return photos.photoArray.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.post = posts.postArray[indexPath.row]
        if photos.photoArray.count > indexPath.row {
            cell.photoImage.image = photos.photoArray[indexPath.row].image
        }
//        for post in self.posts.postArray {
//
//            // post.documentID
////            self.photos.loadData(post: post) {
////                self.photo = self.photos.photoArray[indexPath.row]
////            }
//        for index in 0..<photos.photoArray.count {
//            cell.photoImage.image = photos.photoArray[index].image
//        }
        return cell
    }
            //        for post in posts.postArray {
            //            cell.photo = photos.photoArray[0]
           //        }
            //        if posts.postArray.count == photos.photoArray.count {
            //            cell.post = posts.postArray[indexPath.row]
            //            cell.photo = photos.photoArray[indexPath.row]
            //        } else {
            //            cell.post = posts.postArray[indexPath.row]
            //        }
            //        return cell
    
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 255
    }
        
}
