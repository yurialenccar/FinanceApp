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
    var bank : Banks
    var brand : CardBrand
    var closingDay : Int
    var dueDate : Int
    var standardCard: Bool
    
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
    CreditCard(id: "card00", desc: "Cartão Ultravioleta Nubank", bank: .nubank, brand: .masterCard, closingDay: 25, dueDate: 30, standardCard: false),
    CreditCard(id: "card01", desc: "Cartão Click Itau", bank: .itau, brand: .visa, closingDay: 20, dueDate: 25, standardCard: false),
    CreditCard(id: "card02", desc: "Cartão Inter", bank: .inter, brand: .americanExpress, closingDay: 22, dueDate: 27, standardCard: false)
]
