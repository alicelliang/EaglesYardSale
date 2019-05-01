//
//  Post.swift
//  Eagles Yard Sale
//
//  Created by Alice Liang on 4/23/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Post {
    var seller: String
    var postingUserID: String
    var school: String
    var department: String
    var bookTitle: String
    var price: Double
    var documentID: String
    var contactInfo: String
    
    var dictionary: [String: Any] {
        return ["seller": seller, "postingUserID": postingUserID,"school": school, "department": department, "bookTitle": bookTitle, "price": price, "contactInfo": contactInfo]
    }
    
    init(seller: String, postingUserID: String, school: String, department: String, bookTitle: String, price: Double, documentID: String, contactInfo: String) {
        self.seller = seller
        self.postingUserID = postingUserID
        self.school = school
        self.department = department
        self.bookTitle = bookTitle
        self.price = price
        self.documentID = documentID
        self.contactInfo = contactInfo
    }
    
    convenience init() {
        self.init(seller: "", postingUserID: "", school: "", department: "", bookTitle: "", price: 0.0, documentID: "", contactInfo: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let seller = dictionary["seller"] as! String? ?? ""
        let school = dictionary["school"] as! String? ?? ""
        let department = dictionary["department"] as! String? ?? ""
        let bookTitle = dictionary["bookTitle"] as! String? ?? ""
        let price = dictionary["price"] as! Double? ?? 0.0
        let contactInfo = dictionary["contactInfo"] as! String? ?? ""
        self.init(seller: seller, postingUserID: "", school: school, department: department, bookTitle: bookTitle, price: price, documentID: "", contactInfo: contactInfo)
    }
    
    func saveData(completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
       
        
        // Grab the userID
        guard let postingUserID = (Auth.auth().currentUser?.uid) else {
            print("*** ERROR: Could not save data because we don't have a valid postingUserID")
            return completed(false)
        }
        self.postingUserID = postingUserID
        
        // Create the dictionary representing the data we want to save
        let dataToSave = self.dictionary
        
        // if we HAVE saved a record, we'll have a documentID
        if self.documentID != "" {
            let ref = db.collection("posts").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("*** ERROR: updating document \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ Document updated with ref ID \(ref.documentID)")
                    completed(true)
                }
            }
        } else {
            var ref: DocumentReference? = nil // Let firestore create the new documentID
            ref = db.collection("posts").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("*** ERROR: creating new document \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ new document created with ref ID \(ref?.documentID ?? "unknown")")
                    self.documentID = ref!.documentID
                    completed(true)
                }
            }
        }
    }
    
}
