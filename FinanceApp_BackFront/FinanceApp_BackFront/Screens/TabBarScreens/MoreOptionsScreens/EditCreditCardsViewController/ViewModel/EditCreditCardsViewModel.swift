//
//  EditCreditCardsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import Foundation
import UIKit

class EditCreditCardsViewModel{
    
    public var configType: ConfigType
    private var card: CreditCard
    
    init(card: CreditCard, configType: ConfigType) {
        self.configType = configType
        self.card = card
    }
    
    public func saveCreditCard(newCard: CreditCard) -> CreditCard {
        var creditCard: CreditCard = newCard
        
        if newCard.desc.isEmptyTest() {
            creditCard.desc = "\(moreOptionsStrings.cardText) \(bankProperties[newCard.bank]?.textNameBank ?? moreOptionsStrings.ofCreditText)"
        }
        return creditCard
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
