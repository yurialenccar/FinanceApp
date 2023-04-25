//
//  CreditCardModalCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 25/04/23.
//

import UIKit

class CreditCardModalCell: UITableViewCell {

    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    @IBOutlet weak var descLabel: UILabel!
    
    
    static let identifier:String = String(describing: CreditCardModalCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setupCell(creditCard:CreditCard){
        descLabel.text = creditCard.desc
        bankLabel.text = creditCard.bank.rawValue
        bankLabel.textColor = bankColors[creditCard.bank]?.labelBankColor
        bankBackground.backgroundColor = bankColors[creditCard.bank]?.backgroundColor
        
    }
    
}
