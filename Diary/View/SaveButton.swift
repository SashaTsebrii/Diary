//
//  SaveButton.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/5/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class SaveButton: UIButton {
    
    // MARK: Initialization
    
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
        let textColor = UIColor.white
        let disabledColor = textColor.withAlphaComponent(0.3)
        
        guard let customFont = UIFont(name: Constant.CustomFont.bold, size: 12) else {
            fatalError("""
        Failed to load the "SF-Pro-Display-Bold" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """)
        }
        
        self.backgroundColor = UIColor.DesignColor.orange
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
        self.setTitle("SAVE", for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.setTitleColor(disabledColor, for: .disabled)
        self.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont)
        self.titleLabel?.adjustsFontForContentSizeCategory = true
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    // MARK: Selectors
    
    @objc func onPress() {
        
    }
}
