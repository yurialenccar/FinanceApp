//
//  ExchangeRate.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 23/06/23.
//

import Foundation

// MARK: - ExchangeRate
struct ExchangeRate: Codable {
    let result: String
    let timeLastUpdateUnix: Double
    let timeLastUpdateUtc: String
    let timeNextUpdateUnix: Double
    let timeNextUpdateUtc: String
    let baseCode: String
    let conversionRates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case timeLastUpdateUnix = "time_last_update_unix"
        case timeLastUpdateUtc = "time_last_update_utc"
        case timeNextUpdateUnix = "time_next_update_unix"
        case timeNextUpdateUtc = "time_next_update_utc"
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}


