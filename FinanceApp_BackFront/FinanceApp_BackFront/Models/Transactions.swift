//
//  File.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 05/04/23.
//

import Foundation

struct Transactions{
    
    var desc:String
    var value:Double
    var categoryIndex:Int
    var date:String
}

let transactions: [Transactions] = [
    Transactions(desc: "Hamburgueria", value: -59.00, categoryIndex: 1, date: "29/03/2023"),
    Transactions(desc: "Aluguel", value: -1500.00, categoryIndex: 1, date: "28/03/2023"),
    Transactions(desc: "Aplicativo", value: 12000.00, categoryIndex: 1, date: "27/03/2023")
]
