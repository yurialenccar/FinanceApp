//
//  File.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 05/04/23.
//

import Foundation

struct Transactions{
    
    var desc:String
    var amount:Double
    var categoryIndex:Int
    var date:String
    var type:TransactionType
    var accountId:String
    var obs:String
}



var transactions: [Transactions] = [
    Transactions(desc: "Hamburgueria", amount: -59.00, categoryIndex: 0, date: "29/03/2023",type: .expense, accountId: "conta01", obs: ""),
    Transactions(desc: "Aluguel", amount: -1500.00, categoryIndex: 1, date: "28/03/2023",type: .expense, accountId: "conta01", obs: ""),
    Transactions(desc: "Pizza", amount: -41.00, categoryIndex: 0, date: "29/03/2023",type: .expense, accountId: "conta01", obs: ""),
    Transactions(desc: "Carro", amount: -500.00, categoryIndex: 2, date: "28/03/2023",type: .expense, accountId: "conta01", obs: ""),
    Transactions(desc: "Aplicativo", amount: 12000.00, categoryIndex: 0, date: "27/03/2023", type: .income, accountId: "conta01", obs: "")
]


