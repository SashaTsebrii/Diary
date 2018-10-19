//
//  Switcher.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/7/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class Switcher {
    
    static func updateRootVC() {
        
        let isSignIn = UserDefaults.standard.bool(forKey: Constants.kUserDefaults.isSignIn)
        print(isSignIn)
        
        var navigationController: UINavigationController?
        
        let rootViewController = isSignIn == true ?
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.listViewController) as! ListViewController :
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.signInViewController) as! SignInViewController
        
        navigationController = MainNavigationController(rootViewController: rootViewController)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = navigationController
        
    }
    
}
