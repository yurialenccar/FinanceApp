//
//  File.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 19/04/23.
//

import Foundation

enum BalanceCardsType {
    case incomes
    case expenses
    case balance
}

struct BalanceCard {
    var type: BalanceCardsType
    var balance: Double
    var lastTransaction: String
}
