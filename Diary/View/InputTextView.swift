//
//  InputTextView.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 9/26/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class InputTextView: UITextView {
    
    override func layoutSubviews() {
        recenter()
    }
    
    private func recenter() {
        var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
        topCorrection = max(0, topCorrection)
        contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
    }
    
}
