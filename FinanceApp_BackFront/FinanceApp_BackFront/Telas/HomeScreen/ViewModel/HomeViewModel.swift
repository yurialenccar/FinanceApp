//
//  HomeViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 19/04/23.
//

import Foundation

struct HomeViewModel {
    
    var transactionsViewModel : TransactionsViewModel = TransactionsViewModel()
    
    public func updateBalance() -> BalanceValues {
        
        let transactions = transactionsViewModel.getTransactions()
        var balance : BalanceValues = BalanceValues(total: 0.0, incomesTotal: 0.0, expensesTotal: 0.0)
        
        
        
        for transaction in transactions {
            if transaction.type == .income {
                balance.incomesTotal += transaction.amount
            } else if transaction.type == .expense {
                balance.expensesTotal += transaction.amount
            }
        }
        
        balance.total = balance.incomesTotal - balance.expensesTotal
        
        return balance
    }
    

    
}
