//
//  AccountsModalViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 23/04/23.
//

import Foundation

class AccountsModalViewModel {
    
    public func getAccountsCount() -> Int {
        return bankAccountsList.count
    }
    
    public func getItemAccount(_ index:Int) -> BankAccount {
        return bankAccountsList[index]
    }
    
    public func getHeightSize() -> CGFloat {
        return 60
    }
}
