//
//  ListTableViewCell.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 9/13/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

// MARK: -
class ListTableViewCell: UITableViewCell {
    
    // MARK: - Property
    
    var note: NoteData? {
        didSet {
            if let note = note {
                cellLabel.text = note.text
            }
        }
    }
    
    // MARK: - Outlet
    
    @IBOutlet weak var cellView: UIView! {
        didSet {
            cellView.layer.cornerRadius = 8
            cellView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var cellLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
