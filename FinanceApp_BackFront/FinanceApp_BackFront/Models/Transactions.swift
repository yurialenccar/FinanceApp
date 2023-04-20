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
    var account:String
    var obs:String
}

enum TransactionType {
    case income
    case expense
}



