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
    private var creditCard:CreditCard
    
    //Populate Screen fields variables
    public var popCreditCardDesc:String
    public var popCreditCardLimit:String
    public var popCreditCardBank:Banks
    public var popCreditCardClosingDay:String
    public var popCreditCardDueDate:String
    public var popCreditCardStardardCard:Bool
    public var popCreditCardObs:String
    
    
    init(configType: ConfigType, indexCard:Int) {
        self.configType = configType
        
        if configType == .createNew{
            self.creditCard = CreditCard(id: "", desc: "", limit: 1000.0, bank: .bancoDoBrasil, closingDay: 05, dueDate: 10, standardCard: false, obs: "")
        } else {
            self.creditCard = creditCardsList[indexCard]
        }
        self.indexCard = indexCard
        
        self.popCreditCardDesc = creditCard.desc
        self.popCreditCardLimit = String(creditCard.limit)
        self.popCreditCardClosingDay = formatDay(day: creditCard.closingDay)
        self.popCreditCardDueDate = formatDay(day: creditCard.dueDate)
        self.popCreditCardStardardCard = creditCard.standardCard
        self.popCreditCardObs = creditCard.obs
        self.popCreditCardBank = creditCard.bank
    }
    
    public func saveCreditCard(desc: String, limit:Double, bank:Banks, closingDay:Int, dueDate:Int, standardCard:Bool, Obs:String){
        
        if stringIsEmpty(text: desc){
            creditCard.desc = "Cartão \(bankProperties[bank]?.textNameBank ?? "de Crédito")"
        } else {
            creditCard.desc = desc
        }
        creditCard.limit = limit
        creditCard.bank = bank
        creditCard.closingDay = closingDay
        creditCard.dueDate = dueDate
        creditCard.standardCard = standardCard
        creditCard.obs = Obs
        
        if standardCard == true {
            for i in 0..<creditCardsList.count{
                creditCardsList[i].standardCard = false
            }
        }
        
        if configType == .createNew{
            creditCard.id = createNewCreditCardId()
            creditCardsList.append(creditCard)
        } else {
            creditCardsList[indexCard] = creditCard
        }
        
    }
    
    private func createNewCreditCardId() -> String {
        var num = creditCardsList.count
        
        let existingIds = Set(creditCardsList.map { $0.id })
        
        while existingIds.contains("card\(num)") {
            num += 1
        }
        
        return "card\(num)"
    }

    
    public func getBankListCount() -> Int {
        return bankList.count
    }
    
    public func getBankName(_ bank:Banks) -> String {
        return bankProperties[bank]?.textNameBank ?? ""
    }
    
    public func getRowHeight() ->CGFloat{
        return 44
    }
    
    public func getBankLabelText(_ bank:Banks) -> String{
        return bankProperties[bank]?.logoTextLabel ?? ""
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
