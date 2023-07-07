//
//  CurrencyViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 29/05/23.
//

import Foundation

protocol CurrencyViewModelProtocol: AnyObject {
    func success()
    func error(error: ErrorRequest)
}

class CurrencyViewModel {
    
    private var service: ExchangeRateService = ExchangeRateService()
    weak var delegate: CurrencyViewModelProtocol?
    public var exchangeRate: ExchangeRate?
    private var lastRequestDate: String?
    private var currencyExchangeRate: Double = 1
    
    var dailyRequestMade: Bool {
        return lastRequestDate == Date().toString(format: globalStrings.dateFormat)
    }
    
    public func updateExchangeRate() {
        let today: String = Date().toString(format: globalStrings.dateFormat)
        if lastRequestDate != today {
            service.getExchangeRate { result in
                switch result {
                case .success(let success):
                    self.exchangeRate = success
                    self.lastRequestDate = Date().toString(format: globalStrings.dateFormat)
                    self.delegate?.success()
                case .failure(let failure):
                    self.delegate?.error(error: failure)
                }
            }
        }
    }

    public func getConvertedValue(sourceCoin: CurrencyInfos, targetCoin: CurrencyInfos, value: Double) -> String {
        let baseValue = exchangeRate?.conversionRates[exchangeRate?.baseCode ?? moreOptionsStrings.baseCurrency] ?? 0
        let sourceRate = exchangeRate?.conversionRates[sourceCoin.code] ?? 0
        let targetRate = exchangeRate?.conversionRates[targetCoin.code] ?? 0
        self.currencyExchangeRate = ((baseValue / sourceRate) * targetRate)
        let result = value * self.currencyExchangeRate
        
        return targetCoin.symbol + globalStrings.spaceChar + formatNumberCurrency(value: result)
    }
    
    public func getCoinInfo(index: Int) -> CurrencyInfos {
        return coinsList[index]
    }
    
    public func getLastExchangeQuote(sourceSymbol: String, targetSymbol: String) -> String {
        return sourceSymbol + moreOptionsStrings.oneMoneyEqual + targetSymbol + globalStrings.spaceChar + formatNumberCurrency(value: currencyExchangeRate)
    }
    
    public func getActualDate() -> String {
        let unixTimestamp: TimeInterval = exchangeRate?.timeLastUpdateUnix ?? 0.0
        let date = Date(timeIntervalSince1970: unixTimestamp)
        return date.toString(format: moreOptionsStrings.momentDateFormat)
    }
    
    public func formatNumberCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: moreOptionsStrings.identifierCurrency)

        return formatter.string(from: NSNumber(value: value)) ?? moreOptionsStrings.noMoneyText
    }
    
}
