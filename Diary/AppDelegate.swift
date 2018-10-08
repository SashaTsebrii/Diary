//
//  AppDelegate.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 7/28/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit
import CoreData
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Properties
    
    var window: UIWindow?
    
    // FIXME: Delete the comment below.
//    var navigationController: UINavigationController?
    
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Global setup.
        UINavigationBar.appearance().tintColor = UIColor.black
        
        // Initialize google sign-in.
        GIDSignIn.sharedInstance().clientID = "560260818064-j58gav8r63o82h639dijbq0vrdq0929l.apps.googleusercontent.com"
        
        // Check user is sign in or sign out.
        Switcher.updateRootVC()
        
        // FIXME: Delete the comment below.
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let rootViewController = GIDSignIn.sharedInstance().hasAuthInKeychain() ?
//            storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.listViewController) :
//            storyboard.instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.signInViewController)
//        navigationController = MainNavigationController(rootViewController: rootViewController)
//
//        self.window?.rootViewController = navigationController
//        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
    
    // MARK: CoreData stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Diary")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: CoreData saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

// FIXME: Delete the comment below.
//extension AppDelegate: GIDSignInDelegate {
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
//              withError error: Error!) {
//        if let error = error {
//            print("\(error.localizedDescription)")
//        } else {
//            // Perform any operations on signed in user here.
//            /*
//            let userId = user.userID                  // For client-side use only!
//            let idToken = user.authentication.idToken // Safe to send to the server
//            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
//            let email = user.profile.email
//            */
//            // ...
//        }
//    }
//    
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
//              withError error: Error!) {
//        // Perform any operations when the user disconnects from app here.
//        // ...
//    }
//}
