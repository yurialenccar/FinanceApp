//
//  AddTrasactionsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 12/04/23.
//

import Foundation
import UIKit

class AddAccountTransactionsViewModel{
    
    var transactionType:TransactionType
    var newTransaction:Transactions
    
    init(type: TransactionType) {
        transactionType=type
        newTransaction = Transactions(desc: "Vazio", amount: 1.0, categoryIndex: 0, date: "01/01/2023", type: type, accountId: "", obs: "")
        
    }
    
    var dataSelecionada = Date()
    
    public func setTransactionsValues(desc: String, amount:String, category:Int, accountId:String, Obs:String){
        
        switch transactionType {
        case .income:
            newTransaction.amount = Double(amount)!
        case .expense:
            newTransaction.amount = -Double(amount)!
        }

        newTransaction.categoryIndex = category
        newTransaction.accountId = accountId
        newTransaction.date = dataSelecionada.toString(format: globalStrings.dateFormat)
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
        //reordenateTransactions()
    }
    
    var standardAccountIndex: Int {
        for (index, account) in bankAccountsList.enumerated(){
            if account.standardAccount == true{
                return index
            }
        }
        return 0
    }
    
    var standardAccountId: String {
        for account in bankAccountsList{
            if account.standardAccount == true{
                return account.getId()
            }
        }
        return bankAccountsList[0].getId()
    }
    
    public func getCategoryLabel(_ indexCategory:Int) -> String {
        switch transactionType{
        case .expense:
            return expenseCategories[indexCategory].name
        case .income:
            return incomeCategories[indexCategory].name
        }
    }
    
    public func getCategoryImageName(_ indexCategory:Int) -> UIImage{
        switch transactionType{
        case .expense:
            return UIImage(imageLiteralResourceName: expenseCategories[indexCategory].imageName)
        case .income:
            return UIImage(imageLiteralResourceName: incomeCategories[indexCategory].imageName)
        }
    }
    
    public func getCategoryBackgroungColor(_ indexCategory:Int) -> UIColor{
        switch transactionType{
        case .expense:
            return expenseCategories[indexCategory].color
        case .income:
            return incomeCategories[indexCategory].color
        }
    }
    
    public func getAccountLabel(_ indexAccount:Int) -> String{
        return bankAccountsList[indexAccount].desc
    }
    
    public func getBankLabelText(_ indexAccount:Int) -> String{
        return bankProperties[bankAccountsList[indexAccount].bank]?.logoTextLabel ?? addStrings.bankText
    }
    
    public func getBankLabelTextFont(_ indexAccount:Int) -> UIFont{
        return UIFont.systemFont(ofSize: bankProperties[bankAccountsList[indexAccount].bank]?.logoTextSize ?? 17, weight: .bold)
    }
    
    public func getBankLabelColor(_ indexAccount:Int) -> UIColor{
        return bankProperties[bankAccountsList[indexAccount].bank]?.labelBankColor ?? .black
    }
    
    public func getBankBackColor(_ indexAccount:Int) -> UIColor{
        return bankProperties[bankAccountsList[indexAccount].bank]?.backgroundColor ?? .gray
    }
    
    
    public func datePickerChange(date: Date) -> String {
        let calendar = Calendar.current
        let today = Date()
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        dataSelecionada = date
        
        switch dataSelecionada.toString(format: globalStrings.dateFormat) {
        case today.toString(format: globalStrings.dateFormat):
            return addStrings.todayText
        case yesterday.toString(format: globalStrings.dateFormat):
            return addStrings.yesterdayText
        case tomorrow.toString(format: globalStrings.dateFormat):
            return addStrings.tomorrowText
        default:
            return date.toString(format: globalStrings.dateFormat)
        }
    }
}
