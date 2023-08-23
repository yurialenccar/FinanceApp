//
//  TransactionsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 20/04/23.
//

import Foundation

struct TransactionsViewModel {
    
    public func reordenateTransactions(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = globalStrings.dateFormat

        transactionsList = transactionsList.sorted(by: { transaction1, transaction2 in
            let data1 = dateFormatter.date(from: transaction1.date)!
            let data2 = dateFormatter.date(from: transaction2.date)!
            return data1 > data2
        })
    }
    
    public func getTransactionsCount() -> Int {
        return transactionsList.count
    }
    
    public func getItemTransactions(_ index:Int) -> Transactions {
        return transactionsList[index]
    }
    
    public func getCellSize(viewWidth:CGFloat) -> CGSize {
        return CGSize (width: viewWidth - 30, height: 85)
    }
}

var transactionsList: [Transactions] = []

