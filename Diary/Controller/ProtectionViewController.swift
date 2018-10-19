//
//  ProtectionViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/16/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit
import LocalAuthentication

class ProtectionViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var biometricLabel: UILabel!
    @IBOutlet weak var biometricSwitch: UISwitch!
    @IBOutlet weak var passwordSwitch: UISwitch!
    @IBOutlet weak var setButton: SettingsButton!
    
    // MARK: Properties
    
    enum BiometricType {
        case none
        case touch
        case face
    }
    
    let userDefaults = UserDefaults.standard
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch ProtectionViewController.biometricType() {
        case .none:
            biometricLabel.text = "Don't support biometric"
            biometricSwitch.isOn = false
            biometricSwitch.isEnabled = false
        case .touch:
            biometricLabel.text = "Use Touch ID"
            // FIXME: Catch Touch ID is on.
            biometricSwitch.isOn = false
            biometricSwitch.isEnabled = true
        case .face:
            biometricLabel.text = "Use Face ID"
            // FIXME: Catch Face ID is on.
            biometricSwitch.isOn = false
            biometricSwitch.isEnabled = true
        }
        
        biometricLabel.isEnabled = false
        biometricSwitch.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isPasswordSet = userDefaults.bool(forKey: Constants.kUserDefaults.isPasswordSet)
        if isPasswordSet == true {
            passwordSwitch.isOn = true
            setButton.isEnabled = true
        } else {
            passwordSwitch.isOn = false
            setButton.isEnabled = false
        }
    }
    
    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueIdentifier.showEnterPasswordFromProtection {
            if let destinationViewController = segue.destination as? EnterPasswordViewController {
                destinationViewController.passwordType = .set
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSetButton(_ sender: SettingsButton) {
        performSegue(withIdentifier: Constants.SegueIdentifier.showEnterPasswordFromProtection, sender: nil)
    }
    
    @IBAction func tapPasswordSwitch(_ sender: UISwitch) {
        if sender.isOn {
            performSegue(withIdentifier: Constants.SegueIdentifier.showEnterPasswordFromProtection, sender: nil)
        } else {
            setButton.isEnabled = false
            userDefaults.set(false, forKey: Constants.kUserDefaults.isPasswordSet)
            userDefaults.set(nil, forKey: Constants.kUserDefaults.currentPassowrd)
            userDefaults.synchronize()
        }
        
    }
    
    // MARK: Helper func
    
    static func biometricType() -> BiometricType {
        let authContext = LAContext()
        if #available(iOS 11, *) {
            let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(authContext.biometryType) {
            case .none:
                return .none
            case .touchID:
                return .touch
            case .faceID:
                return .face
            }
        } else {
            return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
        }
    }
    
}
