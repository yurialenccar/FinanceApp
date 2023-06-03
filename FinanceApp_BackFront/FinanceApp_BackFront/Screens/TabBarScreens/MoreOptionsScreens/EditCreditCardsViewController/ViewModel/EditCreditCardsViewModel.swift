//
//  EditCreditCardsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import Foundation
import UIKit

class EditCreditCardsViewModel{
    
    public var configType:ConfigType
    private var indexCard:Int
    
    init(configType: ConfigType, indexCard:Int) {
        self.configType = configType
        self.indexCard = indexCard
    }
    
    public func populateFieldsInfos() -> CreditCard {
        if configType == .createNew{
            return CreditCard(desc: globalStrings.emptyString, limit: 0.0, bank: .bancoDoBrasil, closingDay: 05, dueDate: 10, standardCard: false, obs: globalStrings.emptyString)
        } else {
            return creditCardsList[indexCard]
        }
    }
    
    public func saveCreditCard(newCard: CreditCard){
        var creditCard: CreditCard = newCard
        
        if newCard.desc.isEmptyTest() {
            creditCard.desc = "\(moreOptionsStrings.cardText) \(bankProperties[newCard.bank]?.textNameBank ?? moreOptionsStrings.ofCreditText)"
        }
        
        if newCard.standardCard == true {
            for i in 0..<creditCardsList.count{
                creditCardsList[i].standardCard = false
            }
        }
        
        if configType == .createNew{
            creditCard.setId(createNewCreditCardId())
            creditCardsList.append(creditCard)
        } else {
            creditCardsList[indexCard].desc = creditCard.desc
            creditCardsList[indexCard].limit = creditCard.limit
            creditCardsList[indexCard].bank = creditCard.bank
            creditCardsList[indexCard].closingDay = creditCard.closingDay
            creditCardsList[indexCard].dueDate = creditCard.dueDate
            creditCardsList[indexCard].standardCard = creditCard.standardCard
            creditCardsList[indexCard].obs = creditCard.obs
        }
        
    }
    
    private func createNewCreditCardId() -> String {
        var num = creditCardsList.count
        
        let existingIds = Set(creditCardsList.map { $0.getId() })
        
        while existingIds.contains(moreOptionsStrings.cardIdText + num.toStringTwoDigits()) {
            num += 1
        }
        
        return moreOptionsStrings.cardIdText + num.toStringTwoDigits()
    }
    
    

    
    public func getBankListCount() -> Int {
        return bankList.count
    }
    
    public func getBankName(_ bank:Banks) -> String {
        return bankProperties[bank]?.textNameBank ?? globalStrings.emptyString
    }
    
    public func getRowHeight() ->CGFloat{
        return 44
    }
    
    public func getBankLabelText(_ bank:Banks) -> String{
        return bankProperties[bank]?.logoTextLabel ?? globalStrings.emptyString
    }
    
    public func getBankLabelTextFont(_ bank:Banks) -> UIFont{
        return UIFont.systemFont(ofSize: bankProperties[bank]?.logoTextSize ?? 17, weight: .bold)
    }
    
    public func getBankLabelColor(_ bank:Banks) -> UIColor{
        return bankProperties[bank]?.labelBankColor ?? UIColor.white
    }
    
    public func getBankBackColor(_ bank:Banks) -> UIColor{
        return bankProperties[bank]?.backgroundColor ??  UIColor.systemBlue
    }
}
