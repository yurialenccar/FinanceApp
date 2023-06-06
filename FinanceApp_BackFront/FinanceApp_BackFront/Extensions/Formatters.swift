//
//  Formatters.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}

extension Int {
    func toStringTwoDigits() -> String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "00"
    }
}

extension Double {
    func toStringMoney() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")

        return formatter.string(from: NSNumber(value: self)) ?? "0.0"
    }
}

