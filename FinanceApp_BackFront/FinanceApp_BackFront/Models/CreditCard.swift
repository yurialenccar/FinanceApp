//
//  creditCard.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import Foundation

struct CreditCard{
    var desc : String
    var bank : Banks
    var brand : CardBrand
    var closingDay : Int
    var dueDate : Int
}

var creditCardsList : [CreditCard] = [
    CreditCard(desc: "Cartão Ultravioleta Nubank", bank: .nubank, brand: .masterCard, closingDay: 25, dueDate: 30),
    CreditCard(desc: "Cartão Click Itau", bank: .itau, brand: .visa, closingDay: 20, dueDate: 25),
    CreditCard(desc: "Cartão Inter", bank: .inter, brand: .americanExpress, closingDay: 22, dueDate: 27)
]
