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
    BankAccount(desc: "Conta Corrente Itau", bank: .bancoDoBrasil, amount: 1000),
    BankAccount(desc: "Conta Corrente Nunbank", bank: .bradesco, amount: -10),
    BankAccount(desc: "Conta Corrente Inter", bank: .caixa, amount: 1500),
]
