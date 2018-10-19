//
//  ReenterPasswordViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/19/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class ReenterPasswordViewController: PasswordViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: Properties
    
    var enteredPassword: String?
    let userDefaults = UserDefaults.standard
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        textField2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        textField3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        textField4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField1.becomeFirstResponder()
    }
    
    // MARK: Actions
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Selectors
    
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        
        if text?.utf16.count == 1 {
            switch textField {
            case textField1:
                textField2.becomeFirstResponder()
            case textField2:
                textField3.becomeFirstResponder()
            case textField3:
                textField4.becomeFirstResponder()
            case textField4:
                textField4.resignFirstResponder()
                
                let reenteredPassword = getTextFromTextFields(textFields: textFields)
                if reenteredPassword == enteredPassword {
                    
                    userDefaults.set(reenteredPassword, forKey: Constants.kUserDefaults.currentPassowrd)
                    userDefaults.set(true, forKey: Constants.kUserDefaults.isPasswordSet)
                    userDefaults.synchronize()
                    navigationController?.popToViewController(ofClass: ProtectionViewController.self)
                } else {
                    let alert = UIAlertController(title: "Incorrect", message: "You entered not the same PIN code.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                        self.removeTextFromTextFields(textFields: self.textFields)
                        self.textField1.becomeFirstResponder()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            default:
                break
            }
        }
    }
    
}
