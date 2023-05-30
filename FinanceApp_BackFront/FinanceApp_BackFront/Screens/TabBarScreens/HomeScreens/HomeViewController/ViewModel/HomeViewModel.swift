//
//  HomeViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 19/04/23.
//

import Foundation

struct HomeViewModel {
    
    private var incomesTotal: Double = 0.0
    private var expensesTotal: Double = 0.0
    private var balanceTotal: Double = 0.0
    private var lastIncomeDate: String = ""
    private var lastExpenseDate: String = ""
    
    private var transactions: [Transactions] = [
        Transactions(desc: "Hamburgueria", amount: -59.00, categoryIndex: 0, date: "29/03/2023",type: .expense, accountId: "account01", obs: ""),
        Transactions(desc: "Aluguel", amount: -1500.00, categoryIndex: 1, date: "28/03/2023",type: .expense, accountId: "account01", obs: ""),
        Transactions(desc: "Pizza", amount: -41.00, categoryIndex: 0, date: "29/03/2023",type: .expense, accountId: "account01", obs: ""),
        Transactions(desc: "Carro", amount: -500.00, categoryIndex: 2, date: "28/03/2023",type: .expense, accountId: "account01", obs: ""),
        Transactions(desc: "Aplicativo", amount: 12000.00, categoryIndex: 0, date: "27/03/2023", type: .income, accountId: "account01", obs: "")
    ]
    
    public func confirmAllAccountsIDs(){
        for i in 0..<bankAccountsList.count {
            bankAccountsList[i].setId("account\(i.toStringTwoDigits())")
        }
    }
    
    public func confirmAllCardsIDs(){
        for i in 0..<creditCardsList.count {
            creditCardsList[i].setId("card\(i.toStringTwoDigits())")
        }
    }
    
    public mutating func updateGeneralBalance() {
        incomesTotal = 0.0
        expensesTotal = 0.0
        balanceTotal = 0.0
        lastIncomeDate = ""
        lastExpenseDate = ""
        
        for transaction in transactions {
            if transaction.type == .income {
                incomesTotal += transaction.amount
                if lastIncomeDate.isEmpty {
                    lastIncomeDate = transaction.date
                }
            } else if transaction.type == .expense {
                expensesTotal -= transaction.amount
                if lastExpenseDate.isEmpty {
                    lastExpenseDate = transaction.date
                }
            }
        }

        balanceTotal = incomesTotal - expensesTotal
        
    }
    
    public func updateAccountsBalance() {
        for i in 0 ..< bankAccountsList.count {
            bankAccountsList[i].setBalance(transactions: transactions)
        }
    }
    
//    public func updateOtherScreensTransactions() {
//        NotificationCenter.default.post(name: Notification.Name(notificationNames.getTransactions), object: transactions)
//    }
        
    
    public mutating func reordenateTransactions(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        transactions = transactions.sorted(by: { transaction1, transaction2 in
            let data1 = dateFormatter.date(from: transaction1.date)!
            let data2 = dateFormatter.date(from: transaction2.date)!
            return data1 > data2
        })
    }
    
    public func getCardInformation(cardNumber: Int) -> BalanceCard {
        switch cardNumber {
        case 0:
            return BalanceCard(type: .incomes, balance: self.incomesTotal, lastTransaction: self.lastIncomeDate)
        case 1:
            return BalanceCard(type: .expenses, balance: self.expensesTotal, lastTransaction: self.lastExpenseDate)
        default:
            return BalanceCard(type: .balance, balance: self.balanceTotal, lastTransaction: "")
        }
    }
    
    public mutating func appendNewTransaction(_ transaction: Transactions) {
        transactions.append(transaction)
        reordenateTransactions()
        updateAccountsBalance()
    }
    
    public func getTransactions() -> [Transactions] {
        return transactions
    }
    
    public func getItemTransaction(_ index: Int) -> Transactions{
        return transactions[index]
    }
    
    public func getTransactionsCount() -> Int {
        return transactions.count
    }
    
    public func sumExpensesByCategory() -> [CategoriesSum] {
        
        var list = [String:Double] ()
        var totalAmount:Double = 0.0
        
        for transaction in transactions where transaction.type == .expense{

            let category: String = expenseCategories[transaction.categoryIndex].name
            
            if (list[category] != nil){ //Sum up the value if there already is an item with this category in dictionary
                
                list[category]! += transaction.amount
            }
            else { //otherwise, we create a new item
                list[category] = transaction.amount
            }
            totalAmount += transaction.amount
            
        }
        
        var result: [CategoriesSum] = []
        for category in list {
            result.append(CategoriesSum(category: category.key, amount: abs(category.value), percent: (100*category.value)/totalAmount))
        }
        
        return result
    }
}
