//
//  AccountCollectionViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    @IBOutlet weak var editImage: UIImageView!
    
    static let identifier:String = String(describing: AccountCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(account:BankAccount){
        nameLabel.text = account.desc
        //balanceLabel.text =
        bankLabel.text = bankProperties[account.bank]?.text
        bankLabel.textColor = bankProperties[account.bank]?.labelBankColor
        bankLabel.font = UIFont.systemFont(ofSize: bankProperties[account.bank]?.textSize ?? 16, weight: .bold)
        bankBackground.backgroundColor = bankProperties[account.bank]?.backgroundColor
        bankBackground.layer.cornerRadius = 10
        bankBackground.layer.masksToBounds = true
    }
    
}
