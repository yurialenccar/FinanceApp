//
//  AddTrasactionsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 12/04/23.
//

import Foundation
import UIKit

func stringIsEmpty(text:String) -> Bool {
    return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
}

class AddAccountTransactionsViewModel{
    
    var transactionType:TransactionType
    var newTransaction:Transactions
    
    init(type: TransactionType) {
        transactionType=type
        newTransaction = Transactions(desc: "Vazio", amount: 1.0, categoryIndex: 0, date: "01/01/2023", type: type, accountIndex: 0, obs: "")
    }
    
    
    
    public func setTransactionsValues(desc: String, amount:String, category:Int, account:Int, Obs:String){
        
        newTransaction.amount = Double(amount)!
        newTransaction.categoryIndex = category
        newTransaction.accountIndex = account
        //newTransaction.date = date
        newTransaction.type = transactionType
        newTransaction.obs = Obs
        
        if stringIsEmpty(text: desc){
            switch transactionType{
            case .expense:
                newTransaction.desc = expenseCategories[newTransaction.categoryIndex].name
                
            case .income:
                newTransaction.desc = incomeCategories[newTransaction.categoryIndex].name
            }
            
        } else {
            newTransaction.desc = desc
        }
        
        transactions.append(newTransaction)
    }
    
    func getCategoryLabel(_ indexCategory:Int) -> String {
        switch transactionType{
        case .expense:
            return expenseCategories[indexCategory].name
        case .income:
            return incomeCategories[indexCategory].name
        }
    }
    
    func getCategoryImageName(_ indexCategory:Int) -> UIImage{
        switch transactionType{
        case .expense:
            return UIImage(imageLiteralResourceName: expenseCategories[indexCategory].imageName)
        case .income:
            return UIImage(imageLiteralResourceName: incomeCategories[indexCategory].imageName)
        }
    }
    
    func getCategoryBackgroungColor(_ indexCategory:Int) -> UIColor{
        switch transactionType{
        case .expense:
            return expenseCategories[indexCategory].color
        case .income:
            return incomeCategories[indexCategory].color
        }
    }
    
    func getAccountLabel(_ indexAccount:Int) -> String{
        return bankAccountsList[indexAccount].desc
    }
    
    func getBankLabelText(_ indexAccount:Int) -> String{
        return bankAccountsList[indexAccount].bank.rawValue
    }
    
    func getBankLabelColor(_ indexAccount:Int) -> UIColor{
        return bankColors[bankAccountsList[indexAccount].bank]!.labelBankColor
    }
    
    func getBankBackColor(_ indexAccount:Int) -> UIColor{
        return bankColors[bankAccountsList[indexAccount].bank]!.backgroundColor
    }
    
    
    
    
    
    
    
    
}
