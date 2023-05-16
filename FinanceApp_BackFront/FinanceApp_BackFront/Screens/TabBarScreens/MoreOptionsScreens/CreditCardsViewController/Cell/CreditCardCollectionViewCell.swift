//
//  CreditCardCollectionViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import UIKit

class CreditCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var invoiceTextLabel: UILabel!
    @IBOutlet weak var invoiceLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var standardCardImage: UIImageView!
    
    static let identifier:String = String(describing: CreditCardCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(card:CreditCard){
        nameLabel.text = card.desc
        invoiceLabel.text = card.invoiceTotal.toStringMoney()
        if card.invoiceTotal < 0 {
            invoiceLabel.textColor = UIColor(named: "RedGeneralExpenses")
        } else{
            invoiceLabel.textColor = UIColor(named: "GreyInformations")
        }
        
        bankLabel.text = bankProperties[card.bank]?.logoTextLabel
        bankLabel.textColor = bankProperties[card.bank]?.labelBankColor
        bankLabel.font = UIFont.systemFont(ofSize: bankProperties[card.bank]?.logoTextSize ?? 16, weight: .bold)
        bankBackground.backgroundColor = bankProperties[card.bank]?.backgroundColor
        bankBackground.layer.cornerRadius = 10
        bankBackground.layer.masksToBounds = true
        if card.standardCard == false {
            standardCardImage.isHidden = true
        } else{
            standardCardImage.isHidden = false
            standardCardImage.image = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)
            standardCardImage.tintColor = UIColor(named: "GreyInformations")
        }
    }
}

