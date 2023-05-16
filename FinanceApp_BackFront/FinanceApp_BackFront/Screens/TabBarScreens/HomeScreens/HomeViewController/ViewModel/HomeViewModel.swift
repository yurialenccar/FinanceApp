//
//  HomeViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 19/04/23.
//

import Foundation

struct HomeViewModel {
    
    public var informationsAreHidden: Bool = false
    
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
    
    public func updateBalanceValues() {
        
        var incomes:Double = 0.0
        var expenses:Double = 0.0
        var total:Double = 0.0
    
        for transaction in transactions {
            if transaction.type == .income {
                incomes += transaction.amount
            } else if transaction.type == .expense {
                expenses -= transaction.amount
            }
        }
        
        total = incomes - expenses
        
        if total > 0 {
            balanceCardValues[.total]?.backgroundColorName = "PositiveBalance"
        } else if total < 0 {
            balanceCardValues[.total]?.backgroundColorName = "RedGeneralExpenses"
        } else {
            balanceCardValues[.total]?.backgroundColorName = "GreyInformations"
        }
        
        balanceCardValues[.incomes]?.balance = incomes
        balanceCardValues[.expenses]?.balance = expenses
        balanceCardValues[.total]?.balance = total
        
        for transaction in transactions {
            if transaction.type == .income{
                balanceCardValues[.incomes]?.lastTransaction = "Ultima entrada: \(transaction.date)"
                break
            }
        }
        
        for transaction in transactions {
            if transaction.type == .expense{
                balanceCardValues[.expenses]?.lastTransaction = "Ultima saída: \(transaction.date)"
                break
            }
        }
    }
    
    public mutating func hideInformations() -> Bool {
        switch informationsAreHidden {
        case false:
            balanceCardValues[.incomes]?.hideInformations = true
            balanceCardValues[.expenses]?.hideInformations = true
            balanceCardValues[.total]?.hideInformations = true
        case true:
            balanceCardValues[.incomes]?.hideInformations = false
            balanceCardValues[.expenses]?.hideInformations = false
            balanceCardValues[.total]?.hideInformations = false
        }
        
        informationsAreHidden.toggle()
        
        return informationsAreHidden
    }
}
