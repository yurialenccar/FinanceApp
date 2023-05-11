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
    
    func setupCell(balance:BalanceValues, cellNumber:Int){
        switch cellNumber{
        case 0:
            titleLabel.text = "Entrada"
            typeImage.image = UIImage(imageLiteralResourceName: "IncomesArrow")
            valueLabel.text = String(formatMoney(value: balance.incomesTotal))
            backgroundColor = .white
            dateLabel.text = "Ultima entrada: 28 de dezembro"
        case 1:
            titleLabel.text = "Saídas"
            typeImage.image = UIImage(imageLiteralResourceName: "ExpensesArrow")
            valueLabel.text = String(formatMoney(value: balance.expensesTotal))
            backgroundColor = .white
            dateLabel.text = "Ultima saída: 28 de dezembro"
        case 2:
            titleLabel.text = "Total"
            typeImage.image = UIImage(systemName: "dollarsign.circle")
            typeImage.tintColor = .white
            valueLabel.text = String(formatMoney(value: balance.total))
            if balance.total > 0 {
                backgroundColor = UIColor(named: "PositiveBalance")
            } else if balance.total < 0 {
                backgroundColor = UIColor(named: "RedGeneralExpenses")
            } else {
                backgroundColor = UIColor(named: "GreyInformations")
            }
            
            dateLabel.text = " "
        default:
            titleLabel.text = "Erro"
        }
        
        
        
    }

}
