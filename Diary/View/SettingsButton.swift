//
//  SettingsButton.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/15/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

@IBDesignable class SettingsButton: UIButton {
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: (imageView?.frame.width)!)
        }
    }

}
