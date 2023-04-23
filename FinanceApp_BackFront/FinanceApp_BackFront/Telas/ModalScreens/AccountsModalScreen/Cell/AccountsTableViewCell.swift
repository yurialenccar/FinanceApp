//
//  AccountsTableViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import UIKit

class AccountsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    
    static let identifier:String = String(describing: AccountsTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(bankAccount:BankAccount){
        descLabel.text = bankAccount.desc
        bankLabel.text = bankAccount.bank.rawValue
    }

    
}
