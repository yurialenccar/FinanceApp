//
//  BankAccountsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import Foundation
import UIKit

class BankAccountsViewModel {
    
    public func getAccountsCount() -> Int {
        return bankAccountsList.count + 1
    }
    
    public func getAccount(_ index:Int) -> BankAccount {
        return bankAccountsList[index]
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
    
    public func getNewAccountButtonText() -> String {
        return moreOptionsStrings.newBankAccountButtonTitle
    }
}
