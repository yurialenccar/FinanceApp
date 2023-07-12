//
//  AccountsResumeTableViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/05/23.
//

import UIKit

class AccountsResumeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descAccountLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    
    static let identifier:String = String(describing: AccountsResumeTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(bankAccount: BankAccount, hideInformations: Bool){
        descAccountLabel.text = bankAccount.desc
        
        if hideInformations {
            balanceLabel.text =  globalStrings.dashHiddenInformation
            balanceLabel.textColor = .black
        } else {
            balanceLabel.text = bankAccount.balance.toStringMoney()
            if bankAccount.balance > 0 {
                balanceLabel.textColor = .GreenGeneralIncomes
            } else if bankAccount.balance < 0 {
                balanceLabel.textColor = .RedGeneralExpenses
            } else {
                balanceLabel.textColor = .black
            }
        }
        bankLabel.text = bankProperties[bankAccount.bank]?.logoTextLabel
        bankLabel.textColor = bankProperties[bankAccount.bank]?.labelBankColor
        bankLabel.font = UIFont.systemFont(ofSize: bankProperties[bankAccount.bank]?.logoTextSize ?? 17, weight: .bold)
        bankBackground.backgroundColor = bankProperties[bankAccount.bank]?.backgroundColor
    }
   
}
