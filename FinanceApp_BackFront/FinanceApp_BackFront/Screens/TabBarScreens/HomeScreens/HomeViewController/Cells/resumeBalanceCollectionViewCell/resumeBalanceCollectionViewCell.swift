//
//  resumeBalanceCollectionViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/05/23.
//

import UIKit

class resumeBalanceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier:String = String(describing: resumeBalanceCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(card: BalanceCard, hideInformations: Bool) {
        switch card.type {
        case .incomes:
            titleLabel.text = homeStrings.incomesText
            typeImage.image = .incomesArrow
            dateLabel.text = homeStrings.lastIncomeText + card.lastTransaction
            backgroundColor = .white
        case .expenses:
            titleLabel.text = homeStrings.expensesText
            typeImage.image = .expensesArrow
            dateLabel.text = homeStrings.lastExpenseText + card.lastTransaction
            backgroundColor = .white
        case .balance:
            titleLabel.text = homeStrings.balanceText
            typeImage.image = .balanceSymbol
            typeImage.tintColor = .white
            dateLabel.text = globalStrings.emptyString
            
            if card.balance > 0 {
                backgroundColor = .PositiveBalance
            } else if card.balance < 0 {
                backgroundColor = .RedGeneralExpenses
            } else {
                backgroundColor = .systemGray4
            }
        }
       
        if hideInformations == true {
            valueLabel.text = globalStrings.circleHiddenInformation
        } else {
            valueLabel.text = card.balance.toStringMoney()
        }
    }

}
