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
    
    @IBOutlet weak var categoryPanelView: UIView!
    
    
    func setup(with transactions:Transactions){
        descLabel.text = transactions.desc
        valueLabel.text = "R$ \(String(format: "%.2f", transactions.value))"
        categoryLabel.text = listedCategories[transactions.categoryIndex].name
        categoryImage.image = listedCategories[transactions.categoryIndex].image
        dateLabel.text = transactions.date
        
        categoryPanelView.backgroundColor = listedCategories[transactions.categoryIndex].color
        
        if transactions.value > 0{
            valueLabel.textColor = .green
        } else {
            valueLabel.textColor = .red
        }
    }
}
