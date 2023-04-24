//
//  CategoriesModalViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 23/04/23.
//

import Foundation

class CategoriesModalViewModel {
    
    //var filteredCategories: [ListedCategories]
    
    public func getCategoriesCount() -> Int {
        //return filteredCategories.count
        return 0
    }
    
    public func getItemCategory(_ index:Int) -> ListedCategories {
        //return filteredCategories[index]
        return ListedCategories(name: "", imageName: "", color: .blue)
    }
    
    public func getHeightSize() -> CGFloat {
        return 60
    }
}
