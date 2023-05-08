//
//  Formatters.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import Foundation

public func formatDate(date: Date) -> String {

    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    
    return formatter.string(from: date)
}

public func formatMoney(value: Double) -> String {

    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "pt_BR")
    
    return formatter.string(from: value as NSNumber) ?? "0.0"
}
