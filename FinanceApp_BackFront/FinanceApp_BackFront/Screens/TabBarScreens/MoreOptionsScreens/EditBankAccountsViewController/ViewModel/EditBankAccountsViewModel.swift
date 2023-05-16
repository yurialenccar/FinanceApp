//
//  ConfigBankAccountViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import Foundation
import UIKit

class EditBankAccountsViewModel{
    
    public var configType:ConfigType
    private var indexAccount:Int
    
    init(configType: ConfigType, indexAccount:Int) {
        self.configType = configType
        self.indexAccount = indexAccount
    }
    
    public func populateFieldsInfos() -> BankAccount{
        if self.configType == .createNew{
            return BankAccount(desc: "", bank: .bancoDoBrasil, overdraft: 0.0, standardAccount: false, obs: "")
        } else {
            return bankAccountsList[indexAccount]
        }
    }
    
    public func saveBankAccount(newBalance: String, newAccount: BankAccount) {
        var bankAccount: BankAccount = newAccount
        
        if stringIsEmpty(text: newAccount.desc){
            bankAccount.desc = "Conta \(bankProperties[newAccount.bank]?.textNameBank ?? "Corrente")"
        }
        
        if bankAccount.standardAccount == true {
            for i in 0..<bankAccountsList.count{
                bankAccountsList[i].standardAccount = false
            }
        }
        
        let newBalanceValue: Double = Double(newBalance) ?? 0.0
        
        if configType == .createNew{
            bankAccount.setId(createNewBankAccountId())
            if newBalanceValue != 0{
                bankAccount.adjustBalance(newBalance: newBalanceValue)
            }
            bankAccountsList.append(bankAccount)
        } else {
            
            if newBalanceValue != bankAccount.balance {
                bankAccountsList[indexAccount].adjustBalance(newBalance: newBalanceValue)
            }
            bankAccountsList[indexAccount].desc = bankAccount.desc
            bankAccountsList[indexAccount].bank = bankAccount.bank
            bankAccountsList[indexAccount].overdraft = bankAccount.overdraft
            bankAccountsList[indexAccount].standardAccount = bankAccount.standardAccount
            bankAccountsList[indexAccount].obs = bankAccount.obs
        }
        
    }
    
    private func createNewBankAccountId() -> String {
        var num = bankAccountsList.count
        
        let existingIds = Set(bankAccountsList.map { $0.getId() })
        
        while existingIds.contains("card\(num.toStringTwoDigits())") {
            num += 1
        }
        
        return "account\(num.toStringTwoDigits())"
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
