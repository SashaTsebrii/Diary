//
//  SettingsViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/11/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit
import MessageUI
import GoogleSignIn

class SettingsViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var pinButton: SettingsButton!
    @IBOutlet weak var problemButton: SettingsButton!
    @IBOutlet weak var suggestButton: SettingsButton!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueIdentifier.showProtectionFromSettings {
            
        }
    }
    
    // MARK: Actions
    
    @IBAction func tapCloseButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapPinButton(_ sender: SettingsButton) {
        performSegue(withIdentifier: Constants.SegueIdentifier.showProtectionFromSettings, sender: nil)
    }
    
    @IBAction func tapProblemButton(_ sender: SettingsButton) {
        sendEmail(withSubject: "Report a problem")
    }
    
    @IBAction func tapSuggestButton(_ sender: SettingsButton) {
        sendEmail(withSubject: "Suggest a feature")
    }
    
    @IBAction func tapLogoOutButton(_ sender: SettingsButton) {
        // FIXME: Need to fix sing out method.
        GIDSignIn.sharedInstance().signOut()
    }
    
}

// MARK: -
extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helper func
    
    func sendEmail(withSubject subject: String) {
        if MFMailComposeViewController.canSendMail() {
            present(configuredMailComposeViewController(withSubject: subject), animated: true)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController(withSubject subject: String) -> MFMailComposeViewController {
        let mailComposerViewController = MFMailComposeViewController()
        // Extremely important to set the 'mailComposeDelegate' property, not the 'delegate' property.
        mailComposerViewController.mailComposeDelegate = self
        
        mailComposerViewController.setToRecipients(["mydaysapp@gmail.com"])
        mailComposerViewController.setSubject(subject)
        
        let model = UIDevice.current.model
        let modelName = UIDevice.modelName
        let systemVersion = UIDevice.current.systemVersion
        
        mailComposerViewController.setMessageBody("\(model) \(modelName) \(systemVersion) \n", isHTML: false)
        
        return mailComposerViewController
    }
    
    func showSendMailErrorAlert() {
        let alert = UIAlertController(title: "You can't send an email", message: "Pleae, setup the email preference on device.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
