//
//  ConfigBankAccountViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import Foundation

class ConfigBankAccountViewModel{
    
    public func getBankListCount() -> Int {
        return bankList.count
    }
    
    public func getBankName(_ index:Int) -> String {
        return bankList[index]
    }
    
    public func getRowHeight() ->CGFloat{
        return 44
    }
    
}
