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
    
    static let identifier:String = "TransactionsCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    func setup(with transactions:Transactions){
        descLabel.text = transactions.desc
        valueLabel.text = "R$ \(String(format: "%.2f", transactions.amount))"
        dateLabel.text = transactions.date
        
        switch transactions.type {
        case .expense:
            categoryLabel.text = expenseCategories[transactions.categoryIndex].name
            categoryImage.image = UIImage(imageLiteralResourceName: expenseCategories[transactions.categoryIndex].imageName)
            categoryPanelView.backgroundColor = expenseCategories[transactions.categoryIndex].color
            valueLabel.textColor = UIColor(named: "RedGeneralExpenses")
        case .income:
            categoryLabel.text = incomeCategories[transactions.categoryIndex].name
            categoryImage.image = UIImage(imageLiteralResourceName: incomeCategories[transactions.categoryIndex].imageName)
            categoryPanelView.backgroundColor = incomeCategories[transactions.categoryIndex].color
            valueLabel.textColor = UIColor(named: "GreenGeneralIncomes")
        }
    }
}
