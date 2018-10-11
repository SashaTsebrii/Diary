//
//  ResizeButton.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/10/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class ResizeButton: UIButton {
    
    // MARK: Propertis
    
    let increaseImage = UIImage(named: "Increase")
    let decreaseImage = UIImage(named: "Decrease")
    var isResized = false
    
    // MARK: Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Set button if it load from code.
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Set button if it load from storyboard.
        self.setup()
    }
    
    // MARK: Functions
    
    private func setup() {
        self.backgroundColor = UIColor.clear
        self.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        self.setImage(increaseImage, for: .normal)
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    // MARK: Selectors
    
    @objc func onPress() {
        if isResized {
            self.setImage(increaseImage, for: .normal)
            isResized = false
        } else {
            self.setImage(decreaseImage, for: .normal)
            isResized = true
        }
    }

}
