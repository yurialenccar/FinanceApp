//
//  CreditCardModalViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 30/05/23.
//

import Foundation

class CreditCardModalViewModel {
    public func getCreditCardsCount() -> Int {
        return creditCardsList.count
    }
    
    public func getItemCard(_ index:Int) -> CreditCard {
        return creditCardsList[index]
    }
    
    public func getHeightSize() -> CGFloat {
        return 60
    }
}
