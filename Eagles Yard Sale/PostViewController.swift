//
//  PostViewController.swift
//  Eagles Yard Sale
//
//  Created by Alice Liang on 4/23/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

   
    @IBOutlet weak var sellerNameField: UITextField!
    @IBOutlet weak var schoolField: UITextField!
    @IBOutlet weak var departmentField: UITextField!
    @IBOutlet weak var bookTitleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contactInfoField: UITextField!
    @IBOutlet weak var imageButton: UIButton!
    
    var currentTextfield = UITextField()
    var pickerView = UIPickerView()
    var imagePicker = UIImagePickerController()
    
    var post: Post!
    var photos: Photos!
//    let myTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00));
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        sellerNameField.borderStyle = UITextField.BorderStyle.roundedRect
        schoolField.borderStyle = UITextField.BorderStyle.roundedRect
        departmentField.borderStyle = UITextField.BorderStyle.roundedRect
        bookTitleField.borderStyle = UITextField.BorderStyle.roundedRect
        contactInfoField.borderStyle = UITextField.BorderStyle.roundedRect
        priceField.borderStyle = UITextField.BorderStyle.roundedRect
        
        
        imagePicker.delegate = self
        
        if post == nil {
            post = Post()
        }
        photos = Photos()
        
    }
    
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if currentTextfield == schoolField {
            return schoolArray.count
        } else if currentTextfield == departmentField && schoolField.text == "MCAS" {
            return mcasClassArray.count
        } else if currentTextfield == departmentField && schoolField.text == "CSOM" {
            return csomClassArray.count
        } else if currentTextfield == departmentField && schoolField.text == "CSON" {
            return csonClassArray.count
        } else if currentTextfield == departmentField && schoolField.text == "LSOE" {
            return lsoeClassArray.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextfield == schoolField {
            return schoolArray[row]
        } else if currentTextfield == departmentField && schoolField.text == "MCAS" {
            return mcasClassArray[row]
        } else if currentTextfield == departmentField && schoolField.text == "CSOM" {
            return csomClassArray[row]
        } else if currentTextfield == departmentField && schoolField.text == "CSON" {
            return csonClassArray[row]
        } else if currentTextfield == departmentField && schoolField.text == "LSOE" {
            return lsoeClassArray[row]
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextfield == schoolField {
            schoolField.text = schoolArray[row]
        } else if currentTextfield == departmentField && schoolField.text == "MCAS" {
            departmentField.text = mcasClassArray[row]
        } else if currentTextfield == departmentField && schoolField.text == "CSOM" {
            departmentField.text = csomClassArray[row]
        } else if currentTextfield == departmentField && schoolField.text == "CSON" {
            departmentField.text = csonClassArray[row]
        } else if currentTextfield == departmentField && schoolField.text == "LSOE" {
            departmentField.text = lsoeClassArray[row]
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        currentTextfield = textField
        
        if currentTextfield == schoolField {
            currentTextfield.inputView = pickerView
        } else if currentTextfield == departmentField && schoolField.text == "MCAS" {
            currentTextfield.inputView = pickerView
        } else if currentTextfield == departmentField && schoolField.text == "CSOM" {
            currentTextfield.inputView = pickerView
        } else if currentTextfield == departmentField && schoolField.text == "CSON" {
            currentTextfield.inputView = pickerView
        } else if currentTextfield == departmentField && schoolField.text == "LSOE" {
            currentTextfield.inputView = pickerView
        }
        
    }
    
    func updateUserInterface() {
        post.seller = sellerNameField.text!
        post.school = schoolField.text!
        post.department = departmentField.text!
        post.bookTitle = bookTitleField.text!
        post.price = Double(priceField.text!)!
        post.contactInfo = contactInfoField.text!
    }
    
    func saveCancelAlert(title: String, message: String, segueIdentifier: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            self.post.saveData { success in
            self.navigationController?.setToolbarHidden(true, animated: true)
            self.cameraOrLibraryAlert()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func cameraOrLibraryAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.accessCamera()
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.accessLibrary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        self.updateUserInterface()
        post.saveData { success in
            //self.updateUserInterface()
            if success {
                self.leaveViewController()
            } else {
                print("*** ERROR: Couldn't leave this view controller because data wasn't saved.")
            }
        }
    }
    
    @IBAction func photoButtonPressed(_ sender: UIButton) {
        if post.documentID == "" {
            saveCancelAlert(title: "This Venue Has Not Been Saved", message: "You must save theis venue before you can add a photo.", segueIdentifier: "AddPhoto")
        } else {
            cameraOrLibraryAlert()
            
        }
    }
}

extension PostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo = Photo()
        photo.image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageButton.isHidden = true
        imageView.image = photo.image
        dismiss(animated: true) {
            photo.saveData(post: self.post) { (success) in
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func accessLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func accessCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            showAlert(title: "Camera Not Available", message: "There is no camera available on this device.")
        }
    }
    
    
}
