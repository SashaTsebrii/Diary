//
//  EnterPasswordViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/17/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class EnterPasswordViewController: PasswordViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: Properties
    
    enum PasswordType {
        case login
        case set
    }
    
    var passwordType: PasswordType = .login
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch passwordType {
        case .login:
            textLabel.text = "Enter your PIN code"
            backButton.isHidden = true
        case .set:
            textLabel.text = "Enter your new PIN code"
            backButton.isHidden = false
        }

        textField1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        textField2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        textField3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        textField4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField1.becomeFirstResponder()
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueIdentifier.showReenterPasswordFromEnterPassword {
            if let destinationViewController = segue.destination as? ReenterPasswordViewController {
                destinationViewController.enteredPassword = sender as? String
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        switch passwordType {
        case .login:
            break
        case .set:
            navigationController?.popViewController(animated: true)
        }
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
                
                switch passwordType {
                case .login:
                    dismiss(animated: true, completion: nil)
                case .set:
                    let enteredPassword = getTextFromTextFields(textFields: textFields)
                    performSegue(withIdentifier: Constants.SegueIdentifier.showReenterPasswordFromEnterPassword, sender: enteredPassword)
                }
            default:
                break
            }
        }
    }

}
