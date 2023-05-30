//
//  CategoriesGraphViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 29/05/23.
//

import Foundation

class CategoriesGraphViewModel {
    
    public func percentFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        return formatter
    }
    
    public func getValuesByCategory() -> [Double] {
        let sum:[CategoriesSum]=sumExpensesByCategory()
        return sum.map{$0.amount}
    }
    
    public func getCategories() -> [String] {
        let sum:[CategoriesSum]=sumExpensesByCategory()
        return sum.map{$0.category}
    }
    
}
