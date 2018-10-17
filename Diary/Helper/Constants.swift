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
    }
    
    // MARK: -
    struct SegueIdentifier {
        static let showReadFromList = "showReadFromList"
        static let showSettingsFromList = "showSettingsFromList"
        static let showProtectionFromSettings = "showProtectionFromSettings"
        static let showPasswordFromProtection = "showPasswordFromProtection"
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
}
