//
//  PasswordViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/19/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Helper func
    
    func getTextFromTextFields(textFields: [UITextField]) -> String {
        var returnText = ""
        for textField in textFields {
            if let text = textField.text {
                returnText.append(text)
            }
        }
        return returnText
    }
    
    func removeTextFromTextFields(textFields: [UITextField]) {
        for textField in textFields {
            textField.text = nil
        }
    }

}
