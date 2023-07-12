//
//  BankAccountsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import Foundation
import UIKit
 
class BankAccountsViewModel {
    
    private var service: FirestoreService = FirestoreService(documentName: firebaseDocumentNames.bankAccounts)
    
    
    public func updateAccounts(completion: @escaping () -> Void) {
        service.getObjectsArrayData(forObjectType: BankAccount.self, documentReadName: firebaseDocumentNames.bankAccounts) { result in
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
        if newAccount.standardAccount {
            clearStandardAccount()
        }
        
        if newBalance != 0{
            adjustBalance(newBalance: newBalance, oldBalance: 0, account: newAccount, completion: completion)
        }
        
        bankAccountsList.append(newAccount)
        
        service.setDocumentName(firebaseDocumentNames.bankAccounts)
        service.addObjectInArray(newAccount) { result in
            if result != "Success" {
                print(result)
            }
            completion()
        }
    }
    
    public func editAccount(account: BankAccount, indexAccount: Int, newBalance: Double, completion: @escaping () -> Void) {
        let oldBalance: Double = bankAccountsList[indexAccount].balance
        
        if account.standardAccount {
            clearStandardAccount()
        }
        bankAccountsList[indexAccount].desc = account.desc
        bankAccountsList[indexAccount].overdraft = account.overdraft
        bankAccountsList[indexAccount].bank = account.bank
        bankAccountsList[indexAccount].standardAccount = account.standardAccount
        bankAccountsList[indexAccount].obs = account.obs
        
        if newBalance != oldBalance {
            adjustBalance(newBalance: newBalance, oldBalance: oldBalance, account: bankAccountsList[indexAccount], completion: completion)
        }
        
        service.setDocumentName(firebaseDocumentNames.bankAccounts)
        service.setArrayObject(bankAccountsList) { result in
            if result != "Success" {
                print(result)
            }
            completion()
        }
    }
    
    private func adjustBalance(newBalance: Double, oldBalance: Double, account: BankAccount, completion: @escaping () -> Void) {
        let valueNewTransaction: Double = newBalance - oldBalance
        var transactionType: TransactionType
        
        if valueNewTransaction >= 0 {
            transactionType = .income
        } else{
            transactionType = .expense
        }
        
        transactionsList.append(Transactions(
                                    desc: "Ajuste de saldo na Conta",
                                    amount: valueNewTransaction,
                                    categoryIndex: 0,
                                    date: Date().toString(format: "dd/MM/yyyy"),
                                    type: transactionType,
                                    accountId: account.getId(),
                                    obs: "Conta: \(account.desc)"
        ))
        
        service.setDocumentName(firebaseDocumentNames.transactions)
        service.setArrayObject(transactionsList) { result in
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
    
    private func clearStandardAccount() {
        for i in 0..<bankAccountsList.count {
            bankAccountsList[i].standardAccount = false
        }
    }
}

var bankAccountsList: [BankAccount] = []
