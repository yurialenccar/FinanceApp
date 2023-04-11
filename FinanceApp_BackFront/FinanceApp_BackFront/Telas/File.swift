//
//  File.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-04-10.
//

import Foundation

extension NumberFormatter {
    static let defaultDecimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}

let formatter = NumberFormatter.defaultDecimal
