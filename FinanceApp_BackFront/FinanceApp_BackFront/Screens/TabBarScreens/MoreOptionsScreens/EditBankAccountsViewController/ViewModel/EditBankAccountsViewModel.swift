//
//  ConfigBankAccountViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import Foundation
import UIKit

class EditBankAccountsViewModel{
    
    public var configType: ConfigType
    private var account: BankAccount
    
    init(account: BankAccount, configType: ConfigType) {
        self.account = account
        self.configType = configType
    }
    
    public func saveBankAccount(newAccount: BankAccount) -> BankAccount {
        var bankAccount: BankAccount = newAccount
        
        if newAccount.desc.isEmptyTest() {
            bankAccount.desc = "\(moreOptionsStrings.accountText) \(bankProperties[newAccount.bank]?.textNameBank ?? moreOptionsStrings.currentText)"
        }
        return bankAccount
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
