//
//  PasswordViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/17/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    
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

    /*
    // MARK: Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Helper func
    
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
            default:
                break
            }
        }
    }

}
