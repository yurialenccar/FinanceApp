//
//  ConfigBankAccountViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import Foundation
import UIKit

class ConfigBankAccountViewModel{
    
    var configType:ConfigType
    var indexAccount:Int
    private var bankAccount:BankAccount
    
    //Populate Screen fields variables
    public var popBankAccountDesc:String
    public var popBankAccountBalance:String
    public var popBankAccountOverdraft:String
    public var popBankAccountStardardBank:Bool
    public var popBankAccountObs:String
    public var popBankAccountBank:Banks
    
    init(configType: ConfigType, indexAccount:Int) {
        self.configType = configType
        
        if configType == .createNew{
            self.bankAccount = bankAccountEmpty
        } else {
            self.bankAccount = bankAccountsList[indexAccount]
        }
        self.indexAccount = indexAccount
        
        self.popBankAccountDesc = bankAccount.desc
        self.popBankAccountBalance = String(bankAccount.balance)
        self.popBankAccountOverdraft = String(bankAccount.overdraft)
        self.popBankAccountStardardBank = bankAccount.stardardAccount
        self.popBankAccountObs = bankAccount.obs
        self.popBankAccountBank = bankAccount.bank
    }
    
    public func saveBankAccount(desc: String, balance:Double, overdraft:Double, bank:Banks, stardardBank:Bool, Obs:String){
        
        if stringIsEmpty(text: desc){
            bankAccount.desc = "Conta \(bankProperties[bank]?.textNameBank ?? "Corrente")"
        } else {
            bankAccount.desc = desc
        }
        bankAccount.balance = balance
        bankAccount.overdraft = overdraft
        bankAccount.bank = bank
        bankAccount.stardardAccount = stardardBank
        bankAccount.obs = Obs
        
        if stardardBank == true {
            for i in 0..<bankAccountsList.count{
                bankAccountsList[i].stardardAccount = false
            }
        }
        
        if configType == .createNew{
            bankAccountsList.append(bankAccount)
        } else {
            bankAccountsList[indexAccount] = bankAccount
        }
        
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
