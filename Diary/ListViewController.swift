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
    
    // MARK: - Outlets
    
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
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.layer.cornerRadius = 8
            saveButton.layer.masksToBounds = true
            isEnableSaveButton(isEnable: false)
        }
    }
    
    // MARK: - Properties
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var notesArray: [[NoteData]] = []
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    // MARK: - Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Catch when keyboard is show.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Add gesture dfo hide keyboard.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - Selector
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustingHeight(true, notification: notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustingHeight(false, notification: notification)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        if inputTextView.isFirstResponder {
            inputTextView.resignFirstResponder()
        }
    }
    
    // MARK: - Action
    
    @IBAction func tapResizeButton(_ sender: UIButton) {
        if heightConstraint.constant == 88 {
            heightConstraint.constant = tableView.bounds.height + 88
        } else {
            heightConstraint.constant = 88
        }
        updateViewConstraints()
    }
    
    @IBAction func tapSeveButton(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let note = NoteData(context: context)
        note.date = Date()
        note.text = inputTextView.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        setupData()
    }
    
    // MARK: - Private
    
    private func adjustingHeight(_ show: Bool, notification: Notification) {
        
        if let userInfo = notification.userInfo {
            let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let animationDurarion = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            if show {
                bottomConstraint?.constant = keyboardFrame.height
                isEnableResizeButton(isEnable: true)
            } else {
                bottomConstraint?.constant = -44
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
    
    private func isEnableSaveButton(isEnable: Bool) {
        if isEnable {
            saveButton.isEnabled = true
            saveButton.backgroundColor = UIColor.DesignColor.orange
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = UIColor.lightGray
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

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if notesArray.count > 0 {
            return notesArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if notesArray.count > 0 {
            if let note = notesArray[section].first {
                return String().sringFrom(date: note.date!)
            } else {
                return nil
            }
        } else {
            return nil
        }
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
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        return 8
    }
    
}

extension ListViewController: UITextViewDelegate {
    
    // MARK: - UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 10 {
            isEnableSaveButton(isEnable: true)
        } else {
            isEnableSaveButton(isEnable: false)
        }
    }
}

extension ListViewController {
    
    // MARK: - CoreData
    
    func setupData() {
        notesArray.removeAll()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let notes = try context.fetch(NoteData.fetchRequest())
            let notesByDate = Dictionary(grouping: notes as! [NoteData], by: { $0.date!.stripTime() })
            for (_, value) in notesByDate {
                self.notesArray.insert(value, at: notesArray.count)
            }
            self.tableView.reloadData()
        }
        catch {
            print("Fetching failed")
        }
        if notesArray.count > 0 {
            tableView.scrollToBottom()
        }
    }
}
