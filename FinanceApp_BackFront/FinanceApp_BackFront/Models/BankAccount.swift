//
//  bankAccounts.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import Foundation

struct BankAccount {
    var desc : String
    var bank : Banks
    var overdraft: Double
    var standardAccount: Bool
    var obs: String
    private var id: String = ""
    public var balance: Double = 0.0
    
    public mutating func setBalance(transactions: [Transactions]) {
        let filteredTransactions = transactions.filter{ $0.accountId == id}
        balance = filteredTransactions.reduce(0, {$0 + $1.amount})
        
    }
    
    init(desc: String, bank: Banks, overdraft: Double, standardAccount: Bool, obs: String) {
        self.desc = desc
        self.bank = bank
        self.overdraft = overdraft
        self.standardAccount = standardAccount
        self.obs = obs
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
