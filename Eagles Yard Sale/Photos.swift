//
//  Photos.swift
//  Eagles Yard Sale
//
//  Created by Alice Liang on 4/24/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import Foundation
import Firebase

class Photos {
    var photoArray: [Photo] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(post: Post, completed: @escaping () -> ())  {
        guard post.documentID != "" else {
            return
        }
        let storage = Storage.storage()
        db.collection("posts").document(post.documentID).collection("photos").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            var loadAttempts = 0
            let storageRef = storage.reference().child(post.documentID)
            // there are querySnapshot!.documents.count documents in the spots snapshot
            for document in querySnapshot!.documents {
                let photo = Photo(dictionary: document.data())
                photo.documentUUID = document.documentID
                self.photoArray.append(photo)
                print("**** photo appended")
                print(photo.documentUUID)
                
                // Loading in Firebase Storage images
                let photoRef = storageRef.child(photo.documentUUID)
                photoRef.getData(maxSize: 25 * 1025 * 1025) { data, error in
                    if let error = error {
                        print("**** ERROR: An error occurred while reading data from file ref: \(photoRef) \(error.localizedDescription)")
                        loadAttempts += 1
                        if loadAttempts >= (querySnapshot!.count) {
                            return completed()
                        }
                    } else {
                        let image = UIImage(data: data!)
                        photo.image = image!
                        loadAttempts += 1
                        if loadAttempts >= (querySnapshot!.count) {
                            return completed()
                        }
                    }
                }
                completed()
            }
        }
    }
}
