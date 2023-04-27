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
    var amount : Double
}

var bankAccountsList : [BankAccount] = [
    BankAccount(desc: "Conta Banco do Brasil", bank: .bancoDoBrasil, amount: 1000),
    BankAccount(desc: "Conta Bradesco", bank: .bradesco, amount: -10),
    BankAccount(desc: "Conta Caixa", bank: .caixa, amount: 1500),
]
