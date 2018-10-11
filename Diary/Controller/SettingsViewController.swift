//
//  SettingsViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/11/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: Properties
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
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
        
    }
    
    // MARK: Actions
    
    @IBAction func tapCloseButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
