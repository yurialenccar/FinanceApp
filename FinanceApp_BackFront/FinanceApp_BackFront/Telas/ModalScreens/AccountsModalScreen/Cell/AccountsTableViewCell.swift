//
//  AccountsTableViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import UIKit

class AccountsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    @IBOutlet weak var descLabel: UILabel!
    
    
    
    static let identifier:String = String(describing: AccountsTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(bankAccount:BankAccount){
        let textSize:Int  = bankProperties[bankAccount.bank]?.textSize ?? 17
        
        descLabel.text = bankAccount.desc
        bankLabel.text = bankProperties[bankAccount.bank]?.text
        bankLabel.font = UIFont.systemFont(ofSize: CGFloat(textSize), weight: .bold)
        bankLabel.textColor = bankProperties[bankAccount.bank]?.labelBankColor
        bankBackground.backgroundColor = bankProperties[bankAccount.bank]?.backgroundColor
    }

    
}
