//
//  TransactionsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 20/04/23.
//

import Foundation

class TransactionsViewModel {
    
    var homeViewModel: HomeViewModel = HomeViewModel()
    //private var transactions: [Transactions] = []
    
    
    public func getTransactionsCount() -> Int {
        return homeViewModel.getTransactionsCount()
    }
    
    public func getItemTransactions(_ index:Int) -> Transactions {
        return homeViewModel.getItemTransaction(index)
    }
    
    public func getCellSize(viewWidth:CGFloat) -> CGSize {
        return CGSize (width: viewWidth - 30, height: 85)
    }
    
//    public func setTransactions(transactions: [Transactions]) {
//        self.transactions = transactions
//    }
}

