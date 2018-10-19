//
//  SignInViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 9/30/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignInViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var signInButton: GIDSignInButton!
    
    // MARK: Properties
    
    let userDefaults = UserDefaults.standard
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        signInButton.style = .wide
        signInButton.contentMode = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}

// MARK: -
extension SignInViewController: GIDSignInUIDelegate {
    
    // MARK: GIDSignInUIDelegate
    
}

// MARK: -
extension SignInViewController: GIDSignInDelegate {
    
    // MARK: GIDSignInUIDelegate
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            /*
             let userId = user.userID                  // For client-side use only!
             let idToken = user.authentication.idToken // Safe to send to the server
             let fullName = user.profile.name
             let givenName = user.profile.givenName
             let familyName = user.profile.familyName
             let email = user.profile.email
             */
            // Change view controller after success sign in.
            
            userDefaults.set(true, forKey: Constants.kUserDefaults.isSignIn)
            userDefaults.synchronize()
            Switcher.updateRootVC()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // Change view controller after success sign out.
        
        userDefaults.set(false, forKey: Constants.kUserDefaults.isSignIn)
        userDefaults.synchronize()
        Switcher.updateRootVC()
    }
}
