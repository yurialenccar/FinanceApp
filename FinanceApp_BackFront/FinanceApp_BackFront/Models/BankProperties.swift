//
//  bankAppearence.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 23/04/23.
//

import Foundation
import UIKit

struct BankProperties {
    var text: String
    var textSize:CGFloat
    var backgroundColor: UIColor
    var labelBankColor: UIColor
}

let bankProperties: [Banks: BankProperties] = [
    .itau: BankProperties(text: "ITAU", textSize: 16, backgroundColor: .orange, labelBankColor: .blue),
    .bradesco: BankProperties(text: "BRAD", textSize: 14, backgroundColor: .red, labelBankColor: .white),
    .nubank: BankProperties(text: "NU", textSize: 17, backgroundColor: .purple, labelBankColor: .white),
    .inter: BankProperties(text: "INTER", textSize: 13, backgroundColor: .orange, labelBankColor: .white),
    .santander: BankProperties(text: "SANT", textSize: 16, backgroundColor: .red, labelBankColor: .white),
    .caixa: BankProperties(text: "CAIXA", textSize: 13, backgroundColor: .blue, labelBankColor: .orange),
    .bancoDoBrasil: BankProperties(text: "Banco Brasil", textSize: 13, backgroundColor: .yellow, labelBankColor: .blue)
]


