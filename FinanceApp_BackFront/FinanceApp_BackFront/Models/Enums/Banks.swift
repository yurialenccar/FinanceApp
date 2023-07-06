//
//  Banks.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import Foundation

enum Banks: String, Codable {
    case itau
    case bradesco
    case nubank
    case inter
    case santander
    case caixa
    case bancoDoBrasil
    case other
}

let bankList:[Banks]=[
    .itau,
    .bradesco,
    .nubank,
    .inter,
    .santander,
    .caixa,
    .bancoDoBrasil,
    .other
]

