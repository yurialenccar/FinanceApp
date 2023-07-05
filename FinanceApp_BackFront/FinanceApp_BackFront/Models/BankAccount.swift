//
//  bankAccounts.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import Foundation

struct BankAccount: Codable {
    
    private var id: String = ""
    var desc : String
    var bank : Banks
    var overdraft: Double
    var standardAccount: Bool
    var obs: String
    
    var balance: Double {
        let filteredTransactions = transactions.filter{ $0.accountId == id}
        return filteredTransactions.reduce(0, {$0 + $1.amount})
    }
    
    init(desc: String, bank: Banks, overdraft: Double, standardAccount: Bool, obs: String) {
        self.desc = desc
        self.bank = bank
        self.overdraft = overdraft
        self.standardAccount = standardAccount
        self.obs = obs
    }

    public func adjustBalance(newBalance:Double){
        let valueNewTransaction:Double = newBalance - balance
        var transactionType:TransactionType
        
        if valueNewTransaction >= 0{
            transactionType = .income
        } else{
            transactionType = .expense
        }
        
        transactions.append(Transactions(desc: "Ajuste de saldo na Conta", amount: valueNewTransaction, categoryIndex: 0, date: Date().toString(format: "dd/MM/yyyy"), type: transactionType, accountId: id, obs: ""))
    }
    
    public func getId() -> String {
        return id
    }
    
    public mutating func setId(_ newId: String) {
        
        if id == ""{
            id = newId
        }
    }
}

var bankAccountsList : [BankAccount] = [
    BankAccount(desc: "Conta Banco do Brasil", bank: .bancoDoBrasil, overdraft: 100.0, standardAccount: true, obs:""),
    BankAccount(desc: "Conta Bradesco", bank: .bradesco, overdraft: 100.0, standardAccount: false, obs:""),
    BankAccount(desc: "Conta Caixa", bank: .caixa, overdraft: 100.0, standardAccount: false, obs:"")
]
