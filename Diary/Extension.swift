//
//  Extension.swift
//  Diary
//
//  Created by Aleksandr Tsebrii on 9/13/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

// MARK: - String

extension String {
    func sringFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        let stringFromDate = dateFormatter.string(from: date)
        return stringFromDate
    }
}

// MARK: - Date

extension Date {
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
}
