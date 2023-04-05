//
//  TransactionsCollectionViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 05/04/23.
//

import UIKit

class TransactionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func setup(with transactions:Transactions){
        descLabel.text = transactions.desc
        valueLabel.text = "R$ \(String(format: "%.2f", transactions.value))"
        categoryLabel.text = "Alimentação"
        categoryImage.image = UIImage(imageLiteralResourceName: "Alimentação")
        dateLabel.text = transactions.date
        
        if transactions.value > 0{
            valueLabel.textColor = .green
        } else {
            valueLabel.textColor = .red
        }
    }
}
