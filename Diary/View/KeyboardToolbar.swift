//
//  KeyboardToolbar.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/4/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

enum KeyboardToolbarButton: Int {
    
    case save = 0
    case cancel
    
    func createButton(target: Any?, action: Selector?) -> UIBarButtonItem {
        var barButton: UIBarButtonItem!
        
        switch self {
        case .save:
            let button = SaveButton()
            button.addTarget(target, action: action!, for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
            barButton = UIBarButtonItem(customView: button)
            barButton.isEnabled = true
        case .cancel:
            barButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: target, action: action)
            barButton.tintColor = UIColor.lightGray
        }
        
        barButton.tag = rawValue
        return barButton
    }
    
    static func detectType(barButton: UIBarButtonItem) -> KeyboardToolbarButton? {
        return KeyboardToolbarButton(rawValue: barButton.tag)
    }
    
}

// MARK: -
protocol KeyboardToolbarDelegate: class {
    func keyboardToolbar(button: UIBarButtonItem, type: KeyboardToolbarButton, tappedIn toolbar: KeyboardToolbar)
}

// MARK: -
class KeyboardToolbar: UIToolbar {
    
    // MARK: Properties

    weak var toolBarDelegate: KeyboardToolbarDelegate?
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.white
        self.barStyle = UIBarStyle.default
        self.isTranslucent = true
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        self.barTintColor = UIColor.white
        self.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Functions
    
    func setup(leftButtons: [KeyboardToolbarButton], rightButtons: [KeyboardToolbarButton]) {
        
        // Uncomment bellow if want add left button
        /*
        let leftBarButtons = leftButtons.map { (item) -> UIBarButtonItem in
            return item.createButton(target: self, action: #selector(buttonTapped))
        }
        */
        
        let rightBarButtons = rightButtons.map { (item) -> UIBarButtonItem in
            return item.createButton(target: self, action: #selector(buttonTapped(sender:)))
        }
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        setItems(/*leftBarButtons + */[spaceButton] + rightBarButtons, animated: false)
    }
    
    // MARK: - Selectors
    
    @objc func buttonTapped(sender: UIBarButtonItem) {
        if let type = KeyboardToolbarButton.detectType(barButton: sender) {
            toolBarDelegate?.keyboardToolbar(button: sender, type: type, tappedIn: self)
        }
    }

}
