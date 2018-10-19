//
//  Constants.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 7/28/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

struct Constants {
    
    // MARK: -
    struct StoryboardIdentifier {
        static let mainNavigationController = "mainNavigationController"
        static let signInViewController = "signInViewController"
        static let listViewController = "listViewController"
        
        static let readViewController = "readViewController"
        static let enterPasswordViewController = "enterPasswordViewController"
    }
    
    // MARK: -
    struct SegueIdentifier {
        static let showReadFromList = "showReadFromList"
        static let showSettingsFromList = "showSettingsFromList"
        static let showProtectionFromSettings = "showProtectionFromSettings"
        static let showEnterPasswordFromProtection = "showEnterPasswordFromProtection"
        static let showReenterPasswordFromEnterPassword = "showReenterPasswordFromEnterPassword"
    }
    
    // MARK: -
    struct CellIdentifier {
        static let listTableViewCell = "listTableViewCell"
    }
    
    // MARK: -
    struct CustomFont {
        static let bold = "SFProDisplay-Bold"
        static let regular = "SFProDisplay-Regular"
    }
    
    // MARK: -
    struct kUserDefaults {
        static let isSignIn = "isSignIn"
        static let isPasswordSet = "isPasswordSet"
        static let currentPassowrd = "currentPassowrd"
    }
}
