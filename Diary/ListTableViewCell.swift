//
//  ListTableViewCell.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 9/13/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var cellView: UIView! {
        didSet {
            cellView.layer.cornerRadius = 8
            cellView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var cellLabel: UILabel!
    
    // MARK: - Propertids
    
    var note: NoteData? {
        didSet {
            if let note = note {
                cellLabel.text = note.text
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
