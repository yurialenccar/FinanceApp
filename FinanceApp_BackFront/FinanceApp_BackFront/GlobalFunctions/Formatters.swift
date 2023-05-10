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

public func formatTwoDigitNumber(num:Int) -> String {

    let formatter = NumberFormatter()
    formatter.minimumIntegerDigits = 2
    return formatter.string(from: NSNumber(value: num)) ?? ""
}

public func formatMoney(value: Double) -> String {

    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "pt_BR")
    
    return formatter.string(from: NSNumber(value: value)) ?? "0.0"
}

//Transformar em extensions de Double -> String
