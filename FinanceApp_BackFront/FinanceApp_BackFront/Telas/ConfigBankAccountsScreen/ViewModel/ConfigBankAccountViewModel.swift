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
    
    init(configType: ConfigType, indexAccount:Int) {
        self.configType = configType
        self.indexAccount = indexAccount
    }
    
    private var bankAccount:BankAccount = BankAccount(desc: "", bank: .itau, balance: 0.0, overdraft: 0.0, stardardBank: false, obs: "")
    
    public func setBankAccount(desc: String, bank: Banks, balance:Double, overdraft:Double, stardardBank:Bool, Obs:String){
        
        bankAccount.bank = bank
        bankAccount.balance = balance
        bankAccount.overdraft = overdraft
        bankAccount.stardardBank = stardardBank
        bankAccount.obs = Obs
        
        if stringIsEmpty(text: desc){
            bankAccount.desc = "Conta \(bankProperties[bank]?.textNameBank ?? "Corrente")"
        } else {
            bankAccount.desc = desc
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
