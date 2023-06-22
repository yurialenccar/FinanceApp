//
//  creditCardExpenses.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 25/04/23.
//

import Foundation

struct CreditCardExpense {
    var desc:String
    var amount:Double
    var categoryIndex:Int
    var date:String
    var type: TransactionType
    var cardId:String
    var obs:String
}



var creditCardExpenses: [CreditCardExpense] = [
    CreditCardExpense(desc: "Hamburgueria", amount: -59.00, categoryIndex: 0, date: "29/03/2023", type: .expense, cardId: "card00", obs: ""),
    CreditCardExpense(desc: "Aluguel", amount: -1500.00, categoryIndex: 1, date: "28/03/2023", type: .expense, cardId: "card02", obs: ""),
    CreditCardExpense(desc: "Pizza", amount: -41.00, categoryIndex: 1, date: "29/03/2023", type: .expense, cardId: "card01", obs: ""),
    CreditCardExpense(desc: "Carro", amount: -500.00, categoryIndex: 1, date: "28/03/2023", type: .expense, cardId: "card01", obs: ""),
    CreditCardExpense(desc: "Netflix", amount: -50.00, categoryIndex: 0, date: "27/03/2023", type: .expense, cardId: "card00", obs: "")
]
