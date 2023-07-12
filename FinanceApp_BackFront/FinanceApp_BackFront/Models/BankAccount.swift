//
//  bankAccounts.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import Foundation

struct BankAccount: Codable {
    
    private var id: String = UUID().uuidString
    var desc : String
    var bank : Banks
    var overdraft: Double
    var standardAccount: Bool
    var obs: String
    
    var balance: Double {
        let filteredTransactions = transactionsList.filter { $0.accountId == id}
        return filteredTransactions.reduce(0, {$0 + $1.amount})
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
}
