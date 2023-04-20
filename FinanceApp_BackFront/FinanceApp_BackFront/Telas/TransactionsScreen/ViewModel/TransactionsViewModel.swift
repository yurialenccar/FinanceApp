//
//  TransactionsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 20/04/23.
//

import Foundation

struct TransactionsViewModel {
    
    
    
    public func getTransactions() -> [Transactions] {
        return transactions
    }
    
    public mutating func setNewTransaction(_ newTransaction:Transactions) {
        transactions.append(newTransaction)
    }
    
    public func getTransactionsCount() -> Int {
        return transactions.count
    }
    
    public func getItemTransactions(_ index:Int) -> Transactions {
        return transactions[index]
    }
    
    public func getCellSize() -> CGSize {
        return CGSize (width: 361, height: 85)
    }
}

private var transactions: [Transactions] = [
    Transactions(desc: "Hamburgueria", amount: 59.00, categoryIndex: 0, date: "29/03/2023",type: .expense, account: "Conta Itau", obs: ""),
    Transactions(desc: "Aluguel", amount: 1500.00, categoryIndex: 1, date: "28/03/2023",type: .expense, account: "Conta Itau", obs: ""),
    Transactions(desc: "Pizza", amount: 41.00, categoryIndex: 0, date: "29/03/2023",type: .expense, account: "Conta Itau", obs: ""),
    Transactions(desc: "Carro", amount: 500.00, categoryIndex: 2, date: "28/03/2023",type: .expense, account: "Conta Itau", obs: ""),
    Transactions(desc: "Aplicativo", amount: 12000.00, categoryIndex: 0, date: "27/03/2023", type: .income, account: "Conta Itau", obs: "")
]
