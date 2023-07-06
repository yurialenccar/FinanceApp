//
//  creditCard.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import Foundation

struct CreditCard: Codable {
    
    private var id: String = ""
    var desc : String
    var limit: Double
    var bank : Banks
    var closingDay : Int
    var dueDate : Int
    var standardCard: Bool
    var obs:String
    
    var invoiceTotal: Double {
        let filteredTransactions = creditCardExpenses.filter{ $0.cardId == id}
        return filteredTransactions.reduce(0, {$0 + $1.amount})
    }
    
    init (desc: String, limit: Double, bank: Banks, closingDay: Int, dueDate: Int, standardCard: Bool, obs: String) {
        self.desc = desc
        self.limit = limit
        self.bank = bank
        self.closingDay = closingDay
        self.dueDate = dueDate
        self.standardCard = standardCard
        self.obs = obs
    }
    
    public func adjustInvoice(newInvoice:Double){
        let valueNewTransaction:Double = newInvoice - invoiceTotal
        var transactionType:TransactionType
        
        if valueNewTransaction >= 0{
            transactionType = .income
        } else{
            transactionType = .expense
        }
        
        creditCardExpenses.append(CreditCardExpense(desc: "Ajuste valor de Fatura", amount: valueNewTransaction, categoryIndex: 0, date: Date().toString(format: "dd/MM/yyyy"), type: transactionType, cardId: id, obs: ""))
    }
    
    public func getId() -> String {
        return id
    }
    
    public mutating func setId(_ newId: String) {
        
        if self.id == "" {
            self.id = newId
        }
            
    }
}


