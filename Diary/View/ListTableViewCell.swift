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
            cellView.layer.cornerRadius = 4
            cellView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var dateView: UIView! {
        didSet {
            dateView.round(corners: [.topRight, .bottomRight], radius: 4)
            dateView.isHidden = true
        }
    }
    
    @IBOutlet weak var cellLabel: UILabel! {
        didSet {
            cellLabel.text = nil
        }
    }
    
    @IBOutlet weak var monthLabel: UILabel! {
        didSet {
            monthLabel.text = nil
        }
    }
    
    @IBOutlet weak var dayLabel: UILabel! {
        didSet {
            dayLabel.text = nil
        }
    }
    
    // MARK: - Propertids
    
    var isFirst: Bool?
    var note: NoteData? {
        didSet {
            if let note = note {
                cellLabel.text = note.text
                if let isFirst = isFirst {
                    if isFirst {
                        dateView.isHidden = false
                        monthLabel.text = note.date!.monthOfYear()
                        dayLabel.text = note.date!.dayOfWeek()
                    } else {
                        dateView.isHidden = true
                    }
                }
                
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
