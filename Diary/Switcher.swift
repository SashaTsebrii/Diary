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
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var navigationController: UINavigationController?
        
        print(status)
        
        let rootViewController = status == true ?
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.listViewController) as! ListViewController :
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.signInViewController) as! SignInViewController
        
        navigationController = MainNavigationController(rootViewController: rootViewController)
        
        // FIXME: Delete the comment below.
//        if status == true {
//            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbarvc") as! TabBarVC
//        } else {
//            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginvc") as! LoginVC
//        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = navigationController
        
    }
    
}
