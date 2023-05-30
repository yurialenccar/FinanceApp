//
//  String.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 29/05/23.
//

import Foundation

extension String {
    func toDouble() -> Double {
        let valorString = self

        let valorNumericoString = valorString
            .replacingOccurrences(of: "R$", with: "")
            .replacingOccurrences(of: ",", with: ".")
            .trimmingCharacters(in: .whitespaces)

        if let valorNumerico = Double(valorNumericoString) {
            return valorNumerico
        } else {
            return 0.0
        }
    }
}
