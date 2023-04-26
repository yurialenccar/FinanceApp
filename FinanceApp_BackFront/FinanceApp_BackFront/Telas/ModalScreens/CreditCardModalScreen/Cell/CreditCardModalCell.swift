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
        bankLabel.text = bankProperties[creditCard.bank]?.text
        bankLabel.font = UIFont.systemFont(ofSize: CGFloat(bankProperties[creditCard.bank]?.textSize ?? 17), weight: .bold)
        bankLabel.textColor = bankProperties[creditCard.bank]?.labelBankColor
        bankBackground.backgroundColor = bankProperties[creditCard.bank]?.backgroundColor
        
    }
    
}
