//
//  creditCard.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import Foundation

struct CreditCard{
    var id: String
    var desc : String
    var limit: Double
    var bank : Banks
    //var brand : CardBrand
    var closingDay : Int
    var dueDate : Int
    var standardCard: Bool
    var obs:String
    
    public func getInvoiceTotal() -> Double {
        let filteredTransactions = creditCardExpenses.filter{ $0.cardId == id}
        return filteredTransactions.reduce(0, {$0 + $1.amount})
    }
    
    public func adjustInvoice(newInvoice:Double){
        let valueNewTransaction:Double = newInvoice - getInvoiceTotal()
        var transactionType:TransactionType
        
        if valueNewTransaction >= 0{
            transactionType = .income
        } else{
            transactionType = .expense
        }
        
        creditCardExpenses.append(CreditCardExpenses(desc: "Ajuste valor de Fatura", amount: valueNewTransaction, categoryIndex: 0, date: formatDate(date: Date()), type: transactionType, cardId: id, obs: ""))
    }
    
}

var creditCardsList : [CreditCard] = [
    CreditCard(id: "card00", desc: "Cartão Ultravioleta Nubank", limit: 2000.0, bank: .nubank, closingDay: 25, dueDate: 30, standardCard: false, obs: ""),
    CreditCard(id: "card01", desc: "Cartão Click Itau", limit: 2000.0, bank: .itau, closingDay: 20, dueDate: 25, standardCard: false, obs: ""),
    CreditCard(id: "card02", desc: "Cartão Inter", limit: 2000.0, bank: .inter, closingDay: 22, dueDate: 27, standardCard: false, obs: "")
]
