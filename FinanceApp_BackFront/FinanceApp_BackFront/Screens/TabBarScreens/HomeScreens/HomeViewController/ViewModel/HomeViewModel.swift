//
//  HomeViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 19/04/23.
//

import Foundation

struct HomeViewModel {
    
    private var service: FirestoreService = FirestoreService()
    
    private var incomesTotal: Double = 0.0
    private var expensesTotal: Double = 0.0
    private var balanceTotal: Double = 0.0
    private var lastIncomeDate: String = globalStrings.emptyString
    private var lastExpenseDate: String = globalStrings.emptyString
    
    public func getAllData(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        group.enter()
        getTransactions() {
            group.leave()
        }
        
        group.enter()
        getAccounts() {
            group.leave()
        }
        
        group.enter()
        getCreditCards() {
            group.leave()
        }
        
        group.enter()
        getProfileInformations() {
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    private func getTransactions(completion: @escaping () -> Void) {
        service.getObjectsArrayData(forObjectType: Transactions.self, documentReadName: firebaseDocumentNames.transactions) { result in
            switch result {
            case .success(let objectsArray):
                transactionsList = objectsArray
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    private func getAccounts(completion: @escaping () -> Void) {
        service.getObjectsArrayData(forObjectType: BankAccount.self, documentReadName: firebaseDocumentNames.bankAccounts) { result in
            switch result {
            case .success(let object):
                bankAccountsList = object
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    private func getCreditCards(completion: @escaping () -> Void) {
        service.getObjectsArrayData(forObjectType: CreditCard.self, documentReadName: firebaseDocumentNames.creditCards) { result in
            switch result {
            case .success(let object):
                creditCardsList = object
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    public func getProfileInformations(completion: @escaping () -> Void) {
        service.getObject(documentName: firebaseDocumentNames.profile, objectType: Profile.self) { result in
            if let objet = result {
                Utils.saveUserDefaults(value: objet.name, key: "userName")
                Utils.saveUserDefaults(value: objet.email, key: "userEmail")
            }
            completion()
        }
    }
    
    public mutating func updateBalanceValues() {
        incomesTotal = 0.0
        expensesTotal = 0.0
        balanceTotal = 0.0
        lastIncomeDate = globalStrings.emptyString
        lastExpenseDate = globalStrings.emptyString
        
        for transaction in transactionsList {
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
