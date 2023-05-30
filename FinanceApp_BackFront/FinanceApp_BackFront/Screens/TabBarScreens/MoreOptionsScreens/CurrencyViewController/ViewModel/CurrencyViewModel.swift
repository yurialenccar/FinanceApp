//
//  CurrencyViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 29/05/23.
//

import Foundation

class CurrencyViewModel {
    private var currencyExchangeRate: Double = 5.2
    
    public func getConvertedValue(valor: Double) -> String {
        return (valor * currencyExchangeRate).toStringMoney()
    }
    
    public func getActualRealTimeQuote() -> String {
        return "U$ 1,00 = \(currencyExchangeRate.toStringMoney())"
    }
    
    public func getActualDate() -> String {
        let date = Date()
        
        return date.toString(format: "dd 'de' MMMM 'de' yyyy - hh:mm:ss aa")
    }
    
}
