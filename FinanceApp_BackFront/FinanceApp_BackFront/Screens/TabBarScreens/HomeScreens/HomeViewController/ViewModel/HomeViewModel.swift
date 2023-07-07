//
//  HomeViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 19/04/23.
//

import Foundation

struct HomeViewModel {
    
    private var service: FirestoreService = FirestoreService(documentName: "Home")
    //private var utils: Utils = Utils()
    
    private var incomesTotal: Double = 0.0
    private var expensesTotal: Double = 0.0
    private var balanceTotal: Double = 0.0
    private var lastIncomeDate: String = globalStrings.emptyString
    private var lastExpenseDate: String = globalStrings.emptyString
    
    public func updateObjects(completion: @escaping () -> Void) {
        updateAccounts() {
            updateTransactions {
                completion()
            }
        }
    }
    
    public func updateTransactions(completion: @escaping () -> Void) {
        service.getObjectsArrayData(forObjectType: Transactions.self, documentReadName: "transactionsList") { result in
            switch result {
            case .success(let objectsArray):
                transactions = objectsArray
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    public func updateAccounts(completion: @escaping () -> Void) {
        service.getObjectsArrayData(forObjectType: BankAccount.self, documentReadName: "bankAccountsList") { result in
            switch result {
            case .success(let object):
                bankAccountsList = object
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    public func updateProfileInformations(completion: @escaping () -> Void) {
        var profile: Profile = Profile(name: "", email: "")
        service.getObject(documentName: "profile", objectType: Profile.self) { result in
            if let objet = result {
                profile = objet
                Utils.saveUserDefaults(value: profile.name, key: "userName")
                Utils.saveUserDefaults(value: profile.email, key: "userEmail")
            }
            completion()
        }
    }
    
    
    public func confirmAllAccountsIDs(){
        for i in 0..<bankAccountsList.count {
            bankAccountsList[i].setId(homeStrings.accountIdText + i.toStringTwoDigits())
        }
    }
    
    public func confirmAllCardsIDs(){
        for i in 0..<creditCardsList.count {
            creditCardsList[i].setId(homeStrings.cardIdText + i.toStringTwoDigits())
        }
    }
    
    public mutating func updateBalanceValues() {
        incomesTotal = 0.0
        expensesTotal = 0.0
        balanceTotal = 0.0
        lastIncomeDate = globalStrings.emptyString
        lastExpenseDate = globalStrings.emptyString
        
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
    
    public func getCardInformation(cardNumber: Int) -> BalanceCard {
        switch cardNumber {
        case 0:
            return BalanceCard(type: .incomes, balance: self.incomesTotal, lastTransaction: self.lastIncomeDate)
        case 1:
            return BalanceCard(type: .expenses, balance: self.expensesTotal, lastTransaction: self.lastExpenseDate)
        default:
            return BalanceCard(type: .balance, balance: self.balanceTotal, lastTransaction: globalStrings.emptyString)
        }
    }
}
