//
//  ConfigBankAccountViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import Foundation
import UIKit

class ConfigBankAccountViewModel{
    
    private var newBankAccount:BankAccount=BankAccount(desc: "", bank: .itau, balance: 0.0, overdraft: 0.0, stardardBank: false, obs: "")
    
    public func setNewBankAccount(desc: String, bankIndex: Int, balance:Double, overdraft:Double, stardardBank:Bool, Obs:String){
        
        
        
        newBankAccount.bank = bankList[bankIndex]
        newBankAccount.balance = balance
        newBankAccount.overdraft = overdraft
        newBankAccount.stardardBank = stardardBank
        newBankAccount.obs = Obs
        
        if stringIsEmpty(text: desc){
            newBankAccount.desc = "Conta \(bankProperties[bankList[bankIndex]]?.textNameBank ?? "Corrente")"
        } else {
            newBankAccount.desc = desc
        }
        
        bankAccountsList.append(newBankAccount)
    }
    
    
    
    
    public func getBankListCount() -> Int {
        return bankList.count
    }
    
    public func getBankName(_ index:Int) -> String {
        return bankProperties[bankList[index]]?.textNameBank ?? ""
    }
    
    public func getRowHeight() ->CGFloat{
        return 44
    }
    
    public func getBankLabelText(_ index:Int) -> String{
        return bankProperties[bankList[index]]?.logoTextLabel ?? ""
    }
    
    public func getBankLabelTextFont(_ index:Int) -> UIFont{
        return UIFont.systemFont(ofSize: bankProperties[bankList[index]]?.logoTextSize ?? 17, weight: .bold)
    }
    
    public func getBankLabelColor(_ index:Int) -> UIColor{
        return bankProperties[bankList[index]]?.labelBankColor ?? UIColor.white
    }
    
    public func getBankBackColor(_ index:Int) -> UIColor{
        return bankProperties[bankList[index]]?.backgroundColor ??  UIColor.systemBlue
    }
    
    
}
