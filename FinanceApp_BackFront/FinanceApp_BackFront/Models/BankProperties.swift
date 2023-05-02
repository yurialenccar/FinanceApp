//
//  bankAppearence.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 23/04/23.
//

import Foundation
import UIKit

struct BankProperties {
    var textNameBank: String
    var logoTextLabel: String
    var logoTextSize:CGFloat
    var backgroundColor: UIColor
    var labelBankColor: UIColor
}

let bankProperties: [Banks: BankProperties] = [
    .itau: BankProperties(textNameBank:"Banco Itaú", logoTextLabel: "ITAU", logoTextSize: 16, backgroundColor: .orange, labelBankColor: .blue),
    .bradesco: BankProperties(textNameBank:"Banco Bradesco", logoTextLabel: "BRAD", logoTextSize: 14, backgroundColor: .red, labelBankColor: .white),
    .nubank: BankProperties(textNameBank:"Nubank", logoTextLabel: "NU", logoTextSize: 17, backgroundColor: .purple, labelBankColor: .white),
    .inter: BankProperties(textNameBank:"Banco Inter", logoTextLabel: "INTER", logoTextSize: 13, backgroundColor: .orange, labelBankColor: .white),
    .santander: BankProperties(textNameBank:"Banco Santander", logoTextLabel: "SANT", logoTextSize: 16, backgroundColor: .red, labelBankColor: .white),
    .caixa: BankProperties(textNameBank:"Banco Caixa", logoTextLabel: "CAIXA", logoTextSize: 13, backgroundColor: .blue, labelBankColor: .orange),
    .bancoDoBrasil: BankProperties(textNameBank:"Banco do Brasil", logoTextLabel: "Banco Brasil", logoTextSize: 13, backgroundColor: .yellow, labelBankColor: .blue)
]


