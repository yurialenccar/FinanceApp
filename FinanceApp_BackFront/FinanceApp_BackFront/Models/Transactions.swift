//
//  File.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 05/04/23.
//

import Foundation

struct Transactions: Codable {
    var desc: String
    var amount: Double
    var categoryIndex: Int
    var date: String
    var type: TransactionType
    var accountId: String
    var obs: String
}


