//
//  File.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 19/04/23.
//

import Foundation

struct BalanceCards{
    var desc: String
    var balance: Double
    var symbolImageName: String
    var lastTransaction: String
    var backgroundColorName: String
    var hideInformations: Bool
}

enum BalanceCardsType {
    case incomes
    case expenses
    case total
}

var balanceCardValues: [BalanceCardsType:BalanceCards] = [
    .incomes: BalanceCards(desc: "Entradas", balance: 0.0, symbolImageName: "IncomesArrow", lastTransaction: "Ultima entrada: 28 de dezembro", backgroundColorName: "inputBalances", hideInformations: false),
    .expenses: BalanceCards(desc: "Saídas", balance: 0.0, symbolImageName: "ExpensesArrow", lastTransaction: "Ultima saída: 28 de dezembro", backgroundColorName: "inputBalances", hideInformations: false),
    .total: BalanceCards(desc: "Total", balance: 0.0, symbolImageName: "dollarsign.circle", lastTransaction: " ", backgroundColorName: "BackgroundColor", hideInformations: false)
]
