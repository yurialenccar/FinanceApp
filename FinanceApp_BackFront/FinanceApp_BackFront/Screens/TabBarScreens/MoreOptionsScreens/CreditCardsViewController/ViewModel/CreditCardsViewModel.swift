//
//  CreditCardsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import Foundation
import UIKit

class CreditCardsViewModel {
    
    public func getCardsCount() -> Int {
        if creditCardsList.count > 0 {
            return creditCardsList.count + 1
        } else {
            return creditCardsList.count
        }
    }
    
    public func getCard(_ index:Int) -> CreditCard {
        return creditCardsList[index]
    }
    
    public func getCellSize(viewWidth:CGFloat) -> CGSize {
        return CGSize(width: viewWidth - 30, height: 80)
    }
    
    public func getCellCornerRadius()-> CGFloat {
        return 10
    }
    
    public func getCollectionEdgeInsets()-> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
    }
    
    public func getNewCardButtonText() -> String {
        return moreOptionsStrings.newCreditCardButtonTitle
    }
}
