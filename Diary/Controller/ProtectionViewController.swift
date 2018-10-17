//
//  ProtectionViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/16/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class ProtectionViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var touchOrFaceLabel: UILabel!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueIdentifier.showPasswordFromProtection {
            
        }
    }
    
    // MARK: Actions
    
    @IBAction func tapNewNutton(_ sender: SettingsButton) {
        performSegue(withIdentifier: Constants.SegueIdentifier.showPasswordFromProtection, sender: nil)
    }
    
}
