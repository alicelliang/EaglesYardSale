//
//  InitialViewController.swift
//  Eagles Yard Sale
//
//  Created by Alice Liang on 4/24/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import GoogleSignIn


class InitialViewController: UIViewController {

    @IBOutlet weak var csomButton: UIButton!
    @IBOutlet weak var csonButton: UIButton!
    @IBOutlet weak var mcasButton: UIButton!
    @IBOutlet weak var lsoeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var authUI: FUIAuth!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        csomButton.layer.cornerRadius = 15
        csonButton.layer.cornerRadius = 15
        mcasButton.layer.cornerRadius = 15
        lsoeButton.layer.cornerRadius = 15
        addButton.layer.cornerRadius = addButton.frame.width / 2
        
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }
    
    func signIn() {
        let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
        if authUI.auth?.currentUser == nil {
            self.authUI.providers = providers
            present(authUI.authViewController(), animated: true, completion: nil)
        }
    }

}

extension InitialViewController: FUIAuthDelegate {
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let user = user {
            print("*** We signed in with the user \(user.email ?? "unknown e-mail")")
        }
    }
    
    //    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
    //
    //        // Create an instance of the FirebaseAuth login view controller
    //        let loginViewController = FUIAuthPickerViewController(authUI: authUI)
    //
    //        // Set background color to white
    //        loginViewController.view.backgroundColor = UIColor.white
    //
    //        // Create a frame for a UIImageView to hold our logo
    //        let marginInsets: CGFloat = 16 // logo will be 16 points from L and R margins
    //        let imageHeight: CGFloat = 225 // the height of our logo
    //        let imageY = self.view.center.y - imageHeight // places bottom of UIImageView in the center of the login screen
    //        let logoFrame = CGRect(x: self.view.frame.origin.x + marginInsets, y: imageY, width: self.view.frame.width - (marginInsets*2), height: imageHeight)
    //
    //        // Create the UIImageView using the frame created above & add the "logo" image
    //        let logoImageView = UIImageView(frame: logoFrame)
    //        logoImageView.image = UIImage(named: "logo")
    //        logoImageView.contentMode = .scaleAspectFit // Set imageView to Aspect Fit
    //        loginViewController.view.addSubview(logoImageView) // Add ImageView to the login controller's main view
    //        return loginViewController
    //    }
}


