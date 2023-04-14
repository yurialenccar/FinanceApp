//
//  Tela_Inicio.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//


import UIKit
import Charts

class HomeScreen: UIViewController {

    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expensesLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var backgroundBalanceView: UIView!
    @IBOutlet weak var hideInformationsButton: UIButton!
    
    var informationsHidden = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarController?.navigationItem.hidesBackButton = true
        
        //sumExpensesByCategory()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        updateLabels()
    }

    @IBAction func tappedShowGraphScreen(_ sender: UIButton) {
        let vc: CategoriesGraphScreen? = UIStoryboard(name: "CategoriesGraphScreen", bundle: nil).instantiateViewController(withIdentifier: "CategoriesGraphScreen") as? CategoriesGraphScreen
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }

    @IBAction func tappedHideNumbersButton(_ sender: UIButton) {
        if informationsHidden == false {
            informationsHidden = true
            incomeLabel.text = "•••••"
            expensesLabel.text  = "•••••"
            hideInformationsButton.setImage(UIImage(imageLiteralResourceName: "closed eye"), for: .normal)
        } else {
            informationsHidden = false
            updateLabels()
            hideInformationsButton.setImage(UIImage(imageLiteralResourceName: "eye"), for: .normal)
        }
        
        
    }
    
    
    func updateLabels() {
        var incomeTotal = 0.0
        var expensesTotal = 0.0

        for transaction in transactions {
            if transaction.type == .income {
                incomeTotal += transaction.amount
            } else if transaction.type == .expense {
                expensesTotal += transaction.amount
            }
        }

        let balance = incomeTotal - expensesTotal

        incomeLabel.text = String(format: "%.2f", incomeTotal)
        expensesLabel.text = String(format: "%.2f", expensesTotal)
        balanceLabel.text = String(format: "%.2f", balance)
        
        if balance > 0 {
            backgroundBalanceView.backgroundColor = UIColor(named: "PositiveBalance")
            } else if balance < 0 {
                backgroundBalanceView.backgroundColor = UIColor(named: "NegativeBalance")
            } else {
                backgroundBalanceView.backgroundColor = UIColor(named: "GreyInformations")
            }
    }
    
    
}


