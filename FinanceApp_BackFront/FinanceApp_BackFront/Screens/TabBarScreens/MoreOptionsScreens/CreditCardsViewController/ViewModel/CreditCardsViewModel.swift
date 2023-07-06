//
//  CreditCardsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import Foundation
import UIKit

class CreditCardsViewModel {
    
    private var service: FirestoreService = FirestoreService(documentName: "creditCardsList")
    
    public func updateCards(completion: @escaping () -> Void) {
        service.getObjectData(forObjectType: CreditCard.self, documentReadName: "creditCardsList") { result in
            switch result {
            case .success(let objectArray):
                creditCardsList = objectArray
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    public func getCardsCount() -> Int {
            return creditCardsList.count
    }
    
    public func getCard(_ index:Int) -> CreditCard {
        return creditCardsList[index]
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
    
    public func getNewCardButtonText() -> String {
        return moreOptionsStrings.newCreditCardButtonTitle
    }
    
    public func createNewCard(_ newCard: CreditCard, completion: @escaping () -> Void) {
        var card = newCard
        card.setId(createNewCreditCardId())
        
        if card.standardCard {
            clearStandardCard()
        }
        
        creditCardsList.append(card)
        
        service.setArrayObject(creditCardsList) { result in
            if result != "Success" {
                print(result)
            }
            completion()
        }
    }
    
    public func editCard(card: CreditCard, indexCard: Int, completion: @escaping () -> Void) {
        if card.standardCard {
            clearStandardCard()
        }
        creditCardsList[indexCard] = card
        
        service.setArrayObject(creditCardsList) { result in
            if result != "Success" {
                print(result)
            }
            completion()
        }
    }
    
    public func deleteCard(index: Int, completion: @escaping () -> Void) {
        creditCardsList.remove(at: index)
        
        service.setArrayObject(creditCardsList) { result in
            if result != "Success" {
                print(result)
            }
            completion()
        }
    }
    
    private func createNewCreditCardId() -> String {
        var num = creditCardsList.count
        
        let existingIds = Set(creditCardsList.map { $0.getId() })
        
        while existingIds.contains(moreOptionsStrings.cardIdText + num.toStringTwoDigits()) {
            num += 1
        }
        
        return moreOptionsStrings.accountIdText + num.toStringTwoDigits()
    }
    
    private func clearStandardCard() {
        for i in 0..<creditCardsList.count {
            creditCardsList[i].standardCard = false
        }
    }
}

var creditCardsList : [CreditCard] = [
    CreditCard(desc: "Meu Cartão de Crédito", limit: 2000.0, bank: .other, closingDay: 25, dueDate: 30, standardCard: false, obs: ""),
]
