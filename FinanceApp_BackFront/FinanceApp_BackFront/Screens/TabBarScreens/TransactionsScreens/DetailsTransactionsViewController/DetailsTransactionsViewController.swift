//
//  DetailsTransactionsViewController.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 13/07/23.
//

import UIKit

class DetailsTransactionsViewController: UIViewController {
    
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descContainerView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var amountContainerView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateContainerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryContainerView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var backgroundCategoryView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var accountContainerView: UIView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var backgroundBankView: UIView!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var obsContainerView: UIView!
    @IBOutlet weak var obsLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    static let identifier:String = String(describing: DetailsTransactionsViewController.self)
    
    var transaction: Transactions
    
    init?(coder: NSCoder, transaction: Transactions) {
        self.transaction = transaction
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func populateInfos(transaction: Transactions) {
        switch transaction.type {
        case .income:
            titleLabel.text = "Detalhes da Receita"
            titleContainerView.backgroundColor = .GreenAddIncomes
            editButton.tintColor = .GreenAddIncomes
        case .expense:
            titleLabel.text = "Detalhes da Despesa"
            titleContainerView.backgroundColor = .RedAddExpenses
            editButton.tintColor = .RedAddExpenses
            categoryLabel.text = expenseCategories[transaction.categoryIndex].name
            backgroundCategoryView.backgroundColor = expenseCategories[transaction.categoryIndex].colorIndex
        }
        descLabel.text = transaction.desc
        amountLabel.text = transaction.amount
        dateLabel.text = transaction.date
        
        descLabel.text = transaction.desc
        amountLabel.text = transaction.amount
        descLabel.text = transaction.desc
        amountLabel.text = transaction.amount
    }
    
}
