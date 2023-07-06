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



var creditCardExpenses: [CreditCardExpense] = []
