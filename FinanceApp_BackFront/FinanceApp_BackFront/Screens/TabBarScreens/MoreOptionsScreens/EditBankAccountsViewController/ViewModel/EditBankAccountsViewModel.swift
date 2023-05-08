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
            self.bankAccount = BankAccount(id: "", desc: "", bank: .bancoDoBrasil, overdraft: 0.0, stardardAccount: false, obs:"")
        } else {
            self.bankAccount = bankAccountsList[indexAccount]
        }
        self.indexAccount = indexAccount
        
        self.popBankAccountDesc = bankAccount.desc
        self.popBankAccountBalance = String(bankAccount.getBalance())
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
            bankAccount.id = createNewAccountId()
            if balance != 0{
                bankAccount.adjustBalance(newBalance: Double(balance))
            }
            bankAccountsList.append(bankAccount)
        } else {
            if balance != 0{
                bankAccountsList[indexAccount].adjustBalance(newBalance: Double(balance))
            }
            bankAccountsList[indexAccount] = bankAccount
        }
        
    }
    
    private func createNewAccountId() -> String{
        var num = bankAccountsList.count
        var idExists = false
        
        repeat {
            idExists = false
            for account in bankAccountsList {
                if account.id == "conta\(String(format: "%02d", num))" {
                    num += 1
                    idExists = true
                    break
                }
            }
        } while(idExists ==  true)
        
        return "conta\(num)"
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
