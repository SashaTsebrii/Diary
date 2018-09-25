//
//  CreateViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 9/13/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

// MARK: -
class CreateViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var textView: VerticallyCenteredTextView! {
        didSet {
            textView.delegate = self
        }
    }
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem! {
        didSet {
            saveBarButton.isEnabled = false
        }
    }
    
    @IBOutlet weak var bottomTextViewConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
        textView.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Action
    
    @IBAction func tapSaveBarButton(_ sender: UIBarButtonItem) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let note = NoteData(context: context)
        note.date = Date()
        
        note.text = textView.text
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Selector
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            bottomTextViewConstraint.constant = keyboardHeight
        }
    }
    
}

// MARK: -
extension CreateViewController: UITextViewDelegate {
    
    // MARK: - UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 10 {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
}
