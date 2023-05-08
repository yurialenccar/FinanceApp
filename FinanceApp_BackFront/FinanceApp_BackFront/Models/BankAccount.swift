//
//  bankAccounts.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import Foundation

struct BankAccount {
    var id: String
    var desc : String
    var bank : Banks
    var overdraft: Double
    var stardardAccount: Bool
    var obs: String
    
//    init() {
//        id = createNewAccountId()
//    }
    
    
    
    public func getBalance() -> Double {
        let filteredTransactions = transactions.filter{ $0.accountId == id}
        return filteredTransactions.reduce(0, {$0 + $1.amount})
    }
    
    public func adjustBalance(newBalance:Double){
        let valueNewTransaction:Double = newBalance - getBalance()
        var transactionType:TransactionType
        
        if valueNewTransaction >= 0{
            transactionType = .income
        } else{
            transactionType = .expense
        }
        
        transactions.append(Transactions(desc: "Ajuste de saldo na Conta", amount: valueNewTransaction, categoryIndex: 0, date: formatDate(date: Date()), type: transactionType, accountId: id, obs: ""))
    }
}

var bankAccountsList : [BankAccount] = [
    BankAccount(id: "conta00", desc: "Conta Banco do Brasil", bank: .bancoDoBrasil, overdraft: 100.0, stardardAccount: true, obs:""),
    BankAccount(id: "conta01", desc: "Conta Bradesco", bank: .bradesco, overdraft: 100.0, stardardAccount: false, obs:""),
    BankAccount(id: "conta02", desc: "Conta Caixa", bank: .caixa, overdraft: 100.0, stardardAccount: false, obs:"")
]
