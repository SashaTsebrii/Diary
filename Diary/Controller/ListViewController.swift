//
//  ListViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 8/25/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var inputTextView: InputTextView! {
        didSet {
            inputTextView.delegate = self
        }
    }
    
    @IBOutlet weak var resizeButton: UIButton! {
        didSet {
            isEnableResizeButton(isEnable: false)
        }
    }
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notesArray: [[NoteData]] = []
    
    var tapGesture = UITapGestureRecognizer()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextView.text = "Today I..."
        inputTextView.textColor = UIColor.lightGray
        inputTextView.selectedTextRange = inputTextView.textRange(from: inputTextView.beginningOfDocument, to: inputTextView.beginningOfDocument)
                
        // Catch when keyboard is show.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Add gesture dfo hide keyboard.
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        // Setup keyboard's tool bar.
        let toolbar = KeyboardToolbar()
        toolbar.toolBarDelegate = self
        toolbar.setup(leftButtons: [.cancel], rightButtons: [.save])
        inputTextView.inputAccessoryView = toolbar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        // Load data from core data.
        setupData()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == Constant.SegueIdentifier.showReadFromList {
            if let readViewController = segue.destination as? ReadViewController {
                readViewController.note = sender as? NoteData
            }
        }
    }
    
    // MARK: Selector
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustingHeight(true, notification: notification)
        tapGesture.cancelsTouchesInView = true
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustingHeight(false, notification: notification)
        tapGesture.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
//        view.endEditing(true)
        if inputTextView.isFirstResponder {
            inputTextView.resignFirstResponder()
        }
    }
    
    // MARK: Action
    
    @IBAction func tapResizeButton(_ sender: UIButton) {
        if heightConstraint.constant == 44 {
            heightConstraint.constant = tableView.bounds.height + 44
        } else {
            heightConstraint.constant = 44
        }
    }
    
    @IBAction func tapSeveButton(_ sender: UIButton) {

    }
    
    // MARK: Functions
    
    // CoreData load data.
    private func setupData() {
        notesArray.removeAll()
        
        do {
            let notes = try context.fetch(NoteData.fetchRequest())
            let notesByDate = Dictionary(grouping: notes as! [NoteData], by: { $0.date!.stripTime() })
            for (_, value) in notesByDate {
                self.notesArray.insert(value, at: notesArray.count)
            }
            // FIXME: Fix sorting note in array.
            self.tableView.reloadData()
        }
        catch {
            print("Fetching failed")
        }
        if notesArray.count > 0 {
            tableView.scrollToBottom()
        }
    }
    
    // Calculate keyboard hignt.
    private func adjustingHeight(_ show: Bool, notification: Notification) {
        
        if let userInfo = notification.userInfo {
            let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let animationDurarion = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            if show {
                bottomConstraint?.constant = keyboardFrame.height
                isEnableResizeButton(isEnable: true)
            } else {
                bottomConstraint?.constant = 0
                isEnableResizeButton(isEnable: false)
            }
            
            UIView.animate(withDuration: animationDurarion, animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
                if self.notesArray.count > 0 {
                    self.tableView.scrollToBottom()
                }
            }
        }
    }
    
    private func isEnableResizeButton(isEnable: Bool) {
        if isEnable {
            resizeButton.isEnabled = true
            resizeButton.isHidden = false
        } else {
            resizeButton.isEnabled = false
            resizeButton.isHidden = true
        }
    }
}

// MARK: -
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if notesArray.count > 0 {
            return notesArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notesArray.count > 0 {
            return notesArray[section].count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.listTableViewCell, for: indexPath) as! ListTableViewCell
        if notesArray.count > 0 {
            let notes = notesArray[indexPath.section]
            let note = notes[indexPath.row]
            cell.note = note
            cell.isFirst = indexPath.row == 0 ? true : false
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notes = notesArray[indexPath.section]
        let note = notes[indexPath.row]
        performSegue(withIdentifier: Constant.SegueIdentifier.showReadFromList, sender: note)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.DesignColor.screenBackground
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
}


// MARK: -
extension ListViewController: UITextViewDelegate {
    
    // MARK: UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Combine the textView text and the replacement text to create the updated text string
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        // If updated text view will be empty, add the placeholder and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            textView.text = "Today I..."
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
            // Else if the text view's placeholder is showing and the length of the replacement string is greater than 0, set the text color to black then set its text to the replacement string
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }
            // For every other case, the text should change with the usual behavior...
        else {
            return true
        }
        // ...otherwise return false since the updates have already been made
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}



// MARK: -
extension ListViewController: KeyboardToolbarDelegate {
    
    // MARK: KeyboardToolbarDelegate
    
    func keyboardToolbar(button: UIBarButtonItem, type: KeyboardToolbarButton, tappedIn toolbar: KeyboardToolbar) {
        print("Tapped button type: \(type)")
        if type == .save {
            if inputTextView.text.count > 10 {
                let note = NoteData(context: context)
                note.date = Date()
                note.text = inputTextView.text
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                setupData()
                
                inputTextView.text.removeAll()
            } else {
                let alert = UIAlertController(title: "Too short!", message: "Please, enter more characters.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                    }}))
                self.present(alert, animated: true, completion: nil)
            }
        } else if type == .cancel {
            if inputTextView.isFirstResponder {
                inputTextView.resignFirstResponder()
            }
        }
    }
}
