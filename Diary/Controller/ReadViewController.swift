//
//  ReadViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 9/30/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class ReadViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.isEditable = false
        }
    }
    
    // MARK: Properties
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var note: NoteData?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if let note = note {
            dateLabel.text = String().sringFrom(date: note.date!)
            textView.text = note.text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: Actions
    
    @IBAction func tapCloseButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
