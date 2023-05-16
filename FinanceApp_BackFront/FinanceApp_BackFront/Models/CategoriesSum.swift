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

func sumExpensesByCategory() -> [CategoriesSum] {
    
    var list = [String:Double] ()
    var totalAmount:Double = 0.0
    
    for transaction in transactions where transaction.type == .expense{

        let category: String = expenseCategories[transaction.categoryIndex].name
        
        if (list[category] != nil){ //Sum up the value if there already is an item with this category in dictionary
            
            list[category]! += transaction.amount
        }
        else { //otherwise, we create a new item
            list[category] = transaction.amount
        }
        totalAmount += transaction.amount
        
    }
    
    var result: [CategoriesSum] = []
    for category in list {
        result.append(CategoriesSum(category: category.key, amount: abs(category.value), percent: (100*category.value)/totalAmount))
    }
    
    return result
}
