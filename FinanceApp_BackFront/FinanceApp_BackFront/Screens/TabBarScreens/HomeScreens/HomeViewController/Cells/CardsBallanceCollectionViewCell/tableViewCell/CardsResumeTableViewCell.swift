//
//  CardsResumeTableViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/05/23.
//

import UIKit

class CardsResumeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descCardLabel: UILabel!
    @IBOutlet weak var invoiceLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    
    static let identifier:String = String(describing: CardsResumeTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(creditCard:CreditCard, hideInformations: Bool){
        descCardLabel.text = creditCard.desc
        
        if hideInformations{
            invoiceLabel.text = globalStrings.dashHiddenInformation
            invoiceLabel.textColor = .black
        } else {
            invoiceLabel.text = creditCard.invoiceTotal.toStringMoney()
            if creditCard.invoiceTotal > 0 {
                invoiceLabel.textColor = .GreenGeneralIncomes
            } else if creditCard.invoiceTotal < 0 {
                invoiceLabel.textColor = .RedGeneralExpenses
            } else {
                invoiceLabel.textColor = .black
            }
        }
        bankLabel.text = bankProperties[creditCard.bank]?.logoTextLabel
        bankLabel.textColor = bankProperties[creditCard.bank]?.labelBankColor
        bankLabel.font = UIFont.systemFont(ofSize: bankProperties[creditCard.bank]?.logoTextSize ?? 17, weight: .bold)
        bankBackground.backgroundColor = bankProperties[creditCard.bank]?.backgroundColor
    }
   
}
