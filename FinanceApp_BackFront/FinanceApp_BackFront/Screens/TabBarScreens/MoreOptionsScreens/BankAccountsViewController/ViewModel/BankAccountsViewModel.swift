//
//  BankAccountsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import Foundation
import UIKit
 
class BankAccountsViewModel {
    
    private var service: FirestoreService = FirestoreService(documentName: "bankAccountsList")
    
    
    public func updateAccounts(completion: @escaping () -> Void) {
        service.getObjectData(forObjectType: BankAccount.self, documentReadName: "bankAccountsList") { result in
            switch result {
            case .success(let objectArray):
                bankAccountsList = objectArray
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    public func getAccountsCount() -> Int {
        return bankAccountsList.count
    }
    
    public func getAccount(_ index:Int) -> BankAccount {
        if index < bankAccountsList.count {
            return bankAccountsList[index]
        } else {
            return BankAccount(desc: "", bank: .bancoDoBrasil, overdraft: 0, standardAccount: false, obs: "")
        }
        
    }
    
    public func getCellSize(viewWidth:CGFloat) -> CGSize {
        return CGSize(width: viewWidth - 30, height: 80)
    }
    
    public func getCellCornerRadius()-> CGFloat {
        return 10
    }
    
    public func getCollectionEdgeInsets()-> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
    }
    
    public func getNewAccountButtonText() -> String {
        return moreOptionsStrings.newBankAccountButtonTitle
    }
    
    public func createNewAccount(_ newAccount: BankAccount, newBalance: Double, completion: @escaping () -> Void) {
        var account = newAccount
        account.setId(createNewBankAccountId())
        
        if account.standardAccount {
            clearStandardAccount()
        }
        
        if newBalance != 0{
            account.adjustBalance(newBalance: newBalance)
        }
        
        bankAccountsList.append(account)
        
        service.setArrayObject(bankAccountsList) { result in
            if result != "Success" {
                print(result)
            }
            completion()
        }
    }
    
    public func editAccount(account: BankAccount, indexAccount: Int, newBalance: Double, completion: @escaping () -> Void) {
        if account.standardAccount {
            clearStandardAccount()
        }
        bankAccountsList[indexAccount] = account
        
        if newBalance != account.balance {
            account.adjustBalance(newBalance: newBalance)
        }
        
        service.setArrayObject(bankAccountsList) { result in
            if result != "Success" {
                print(result)
            }
            completion()
        }
    }
    
    public func deleteAccount(index: Int, completion: @escaping () -> Void) {
        bankAccountsList.remove(at: index)
        
        service.setArrayObject(bankAccountsList) { result in
            if result != "Success" {
                print(result)
            }
            completion()
        }
    }
    
    private func createNewBankAccountId() -> String {
        var num = bankAccountsList.count
        
        let existingIds = Set(bankAccountsList.map { $0.getId() })
        
        while existingIds.contains(moreOptionsStrings.accountIdText + num.toStringTwoDigits()) {
            num += 1
        }
        
        return moreOptionsStrings.accountIdText + num.toStringTwoDigits()
    }
    
    private func clearStandardAccount() {
        for i in 0..<bankAccountsList.count {
            bankAccountsList[i].standardAccount = false
        }
    }
}

var bankAccountsList: [BankAccount] = []
