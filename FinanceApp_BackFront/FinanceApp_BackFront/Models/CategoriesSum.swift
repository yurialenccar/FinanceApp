//
//  CategoriesSum.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 12/04/23.
//

import Foundation

struct CategoriesSum {
    var category:String
    var amount:Double
    var percent:Double
}

func sumExpensesByCategory()->[CategoriesSum]{
    //var list:[CategoriesSum]=[]
    var list=[String:Double]()
    var totalAmount:Double=0.0
    
    for transaction in transactions where transaction.type == .expense{

        let category:String = expenseCategories[transaction.categoryIndex].name
        
        if (list[category] != nil){ //Se existir um item com a categoria atual no dicionario entao soma-se
            list[category]! += transaction.amount
        }
        else { //caso contrario, apenas cria-se um item
            list[category] = transaction.amount
        }
        totalAmount += transaction.amount
        
    }
    
    var result:[CategoriesSum]=[]
    for category in list {
        result.append(CategoriesSum(category: category.key, amount: category.value, percent: (100*category.value)/totalAmount))
    }
    
    return result
}
