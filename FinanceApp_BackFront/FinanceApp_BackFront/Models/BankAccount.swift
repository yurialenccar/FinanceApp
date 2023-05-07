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
    var balance : Double
    var overdraft: Double
    var stardardAccount: Bool
    var obs: String
}

var bankAccountsList : [BankAccount] = [
    BankAccount(desc: "Conta Banco do Brasil", bank: .bancoDoBrasil, balance: 1000, overdraft: 100.0, stardardAccount: true, obs:""),
    BankAccount(desc: "Conta Bradesco", bank: .bradesco, balance: -10, overdraft: 100.0, stardardAccount: false, obs:""),
    BankAccount(desc: "Conta Caixa", bank: .caixa, balance: 1500, overdraft: 100.0, stardardAccount: false, obs:"")
]

var bankAccountEmpty : BankAccount = BankAccount(desc: "", bank: .bancoDoBrasil, balance: 0.0, overdraft: 0.0, stardardAccount: false, obs:"")
