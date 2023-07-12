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

var transactionsList: [Transactions] = [
//    Transactions(desc: "Hamburgueria", amount: -59.00, categoryIndex: 0, date: "29/03/2023",type: .expense, accountId: "account01", obs: ""),
//    Transactions(desc: "Aluguel", amount: -1500.00, categoryIndex: 1, date: "28/03/2023",type: .expense, accountId: "account01", obs: ""),
//    Transactions(desc: "Pizza", amount: -41.00, categoryIndex: 0, date: "29/03/2023",type: .expense, accountId: "account01", obs: ""),
//    Transactions(desc: "Carro", amount: -500.00, categoryIndex: 2, date: "28/03/2023",type: .expense, accountId: "account01", obs: ""),
//    Transactions(desc: "Aplicativo", amount: 12000.00, categoryIndex: 0, date: "27/03/2023", type: .income, accountId: "account01", obs: "")
]

