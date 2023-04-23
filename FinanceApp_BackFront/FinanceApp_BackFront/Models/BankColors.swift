//
//  bankAppearence.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 23/04/23.
//

import Foundation
import UIKit

struct BankColors {
    var backgroundColor: UIColor
    var labelBankColor: UIColor
}

let bankColors: [Banks: BankColors] = [
    .itau: BankColors(backgroundColor: .orange, labelBankColor: .blue),
    .bradesco: BankColors(backgroundColor: .red, labelBankColor: .white),
    .nubank: BankColors(backgroundColor: .purple, labelBankColor: .white),
    .inter: BankColors(backgroundColor: .orange, labelBankColor: .white),
    .santander: BankColors(backgroundColor: .red, labelBankColor: .white),
    .caixa: BankColors(backgroundColor: .blue, labelBankColor: .orange),
    .bancoDoBrasil: BankColors(backgroundColor: .yellow, labelBankColor: .blue)
]


