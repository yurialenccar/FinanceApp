//
//  CategoriesGraphViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 29/05/23.
//

import Foundation

class CategoriesGraphViewModel {
    
    private var transactions: [Transactions] = []
    
    public func getTransactions(transactions: [Transactions]) {
        self.transactions = transactions
    }
    
    public func percentFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        return formatter
    }
    
    public func getValuesByCategory() -> [Double] {
        let sum: [CategoriesSum] = sumExpensesByCategory()
        return sum.map{$0.amount}
    }
    
    public func getCategories() -> [String] {
        let sum: [CategoriesSum] = sumExpensesByCategory()
        return sum.map{$0.category}
    }
    
    public func sumExpensesByCategory() -> [CategoriesSum] {
        
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
    
}
