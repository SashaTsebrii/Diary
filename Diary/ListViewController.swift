//
//  ListViewController.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 8/25/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit
import CoreData

// MARK: -
class ListViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: - Variable
    
    var notesArray: [[NoteData]] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupData()
        tableView.reloadData()        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.SegueIdentifier.showCreateFromList {
            
        }
    }
    
    // MARK: - Action
    
    @IBAction func tapCreateButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constant.SegueIdentifier.showCreateFromList, sender: nil)
    }
    
}

// MARK: -
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
    
}

// MARK: -

extension ListViewController {
    
    // MARK: - CoreData
    
    func setupData() {
        notesArray.removeAll()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let notes = try context.fetch(NoteData.fetchRequest())
            let notesByDate = Dictionary(grouping: notes as! [NoteData], by: { $0.date!.stripTime() })
            for (_, value) in notesByDate {
                notesArray.append(value)
            }
        }
        catch {
            print("Fetching failed")
        }
    }
}
