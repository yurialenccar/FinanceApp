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
    
    static let identifier:String = String(describing: TransactionsCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    func setup(with transactions:Transactions){
        descLabel.text = transactions.desc
        valueLabel.text = transactions.amount.toStringMoney()
        dateLabel.text = transactions.date
        
        switch transactions.type {
        case .expense:
            categoryLabel.text = expenseCategories[transactions.categoryIndex].name
            categoryImage.image = UIImage(imageLiteralResourceName: expenseCategories[transactions.categoryIndex].imageName).withRenderingMode(.alwaysTemplate)
            categoryPanelView.backgroundColor = categoryColors[expenseCategories[transactions.categoryIndex].colorIndex] ?? UIColor.cyan
            valueLabel.textColor = .RedGeneralExpenses
        case .income:
            categoryLabel.text = incomeCategories[transactions.categoryIndex].name
            categoryImage.image = UIImage(imageLiteralResourceName: incomeCategories[transactions.categoryIndex].imageName).withRenderingMode(.alwaysTemplate)
            categoryPanelView.backgroundColor = categoryColors[incomeCategories[transactions.categoryIndex].colorIndex] ?? UIColor.cyan
            valueLabel.textColor = .GreenGeneralIncomes
        }
        
        categoryImage.tintColor = .black
    }
}
