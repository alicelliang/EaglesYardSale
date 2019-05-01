//
//  Posts.swift
//  Eagles Yard Sale
//
//  Created by Alice Liang on 4/23/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import Foundation
import Firebase


class Posts {
    var postArray = [Post]()
    var db: Firestore!
//    var ref: DatabaseReference!
    
    
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ())  {
        
//        self.postArray = []
//
//        let ref = Database.database().reference(fromURL: "https://eagles-yard-sales.firebaseio.com").child("posts")
//        let query = ref.queryOrdered(byChild: "department").queryEqual(toValue: "Finance")
//        query.observe(.value, with: { snapshot in
//                let post = Post(dictionary: snapshot.value as! [String : Any])
//                self.postArray.append(post)
//        })
        
        db.collection("posts").addSnapshotListener {  (querySnapshot, error)  in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.postArray = []
            // there are querySnapshot!.documents.count documents in teh spots snapshot
            for document in querySnapshot!.documents {
                let post = Post(dictionary: document.data())
                post.documentID = document.documentID
                self.postArray.append(post)
            }
            completed()
        }
    

    }
}
