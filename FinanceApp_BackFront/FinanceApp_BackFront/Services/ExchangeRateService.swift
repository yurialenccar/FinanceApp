//
//  ExchangeRate.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 23/06/23.
//

import Foundation

enum ErrorRequest: Swift.Error {
    case fileNotFound(name: String)
    case fileDecodingFailed(name: String, Swift.Error)
    case errorURLRequest(Swift.Error)
    case errorUrl(urlString: String)
    case errorDetail(detail: String)
}

class ExchangeRateService {
    
    //CurrencyBase in the end of the URL. Using always USD as my conversion base.
    private let urlString: String = "https://v6.exchangerate-api.com/v6/da2a50e5881fa63c5d3c6512/latest/USD"
    
    func getExchangeRate(completion: @escaping (Result<ExchangeRate, ErrorRequest>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(ErrorRequest.errorUrl(urlString: urlString)))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    return completion(.failure(ErrorRequest.errorURLRequest(error)))
                }
                
                guard let data = data else {
                    return completion(.failure(ErrorRequest.errorDetail(detail: "Error Data")))
                }
                
                do {
                    let person = try JSONDecoder().decode(ExchangeRate.self, from: data)
                    completion(.success(person))
                } catch {
                    completion(.failure(ErrorRequest.errorURLRequest(error)))
                }
            }
        }.resume()
    }
    
    func getExchangeRateFromJson(completion: (Result<ExchangeRate, ErrorRequest>) -> Void) {
        if let url = Bundle.main.url(forResource: "ExchangeRate", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let exchangeRate: ExchangeRate = try JSONDecoder().decode(ExchangeRate.self, from: data)
                completion(.success(exchangeRate))
            } catch {
                completion(.failure(ErrorRequest.fileDecodingFailed(name: "data", error)))
            }
        }
    }
}
