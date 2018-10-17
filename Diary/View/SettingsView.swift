//
//  SettingsView.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 10/17/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

@IBDesignable class SettingsView: UIView {
    
    // MARK: Variables
    
    private struct SettingsButtonConstants {
        static let lineWidth: CGFloat = 2.0
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.clear
    @IBInspectable var strokeColor: UIColor = UIColor.DesignColor.screenBackground
    @IBInspectable var isTopLine: Bool = false
    
    // MARK: View
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        fillColor.setFill()
        path.fill()
        
        // Create the path.
        let linePath = UIBezierPath()
        
        // Set the path's line width to the height of the stroke.
        linePath.lineWidth = SettingsButtonConstants.lineWidth
        
        // Move the initial point of the path to the start of the horizontal stroke.
        linePath.move(to: CGPoint(
            x: rect.minX,
            y: rect.maxY))
        
        // Add a point to the path at the end of the stroke.
        linePath.addLine(to: CGPoint(
            x: rect.maxX,
            y: rect.maxY))
        
        if isTopLine {
            // Move the initial point of the path to the start of the horizontal stroke.
            linePath.move(to: CGPoint(
                x: rect.minX,
                y: rect.minY))
            
            // Add a point to the path at the end of the stroke.
            linePath.addLine(to: CGPoint(
                x: rect.maxX,
                y: rect.minY))
        }
        
        // Set the stroke color.
        strokeColor.setStroke()
        linePath.stroke()
    }

}
