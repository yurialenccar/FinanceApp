//
//  CategoriesModalViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 23/04/23.
//

import Foundation

class CategoriesModalViewModel{
    
    var filteredCategories: [ListedCategories]
    
    init(transactionType:TransactionType) {
        if transactionType == .expense {
            self.filteredCategories = expenseCategories
        } else{
            self.filteredCategories = incomeCategories
        }
        
    }
    
    
    
    public func getCategoriesCount() -> Int {
        return filteredCategories.count
    }
    
    public func getItemCategory(_ index:Int) -> ListedCategories {
        return filteredCategories[index]
    }
    
    public func getHeightSize() -> CGFloat {
        return 60
    }
}
