//
//  Tela_Inicio.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//


import UIKit
import Charts

class HomeScreen: UIViewController {
    
    var informationsHidden = false

    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expensesLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var backgroundBalanceView: UIView!
    @IBOutlet weak var hideInformationsButton: UIButton!
    
    var  viewModel : HomeViewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        updateLabels()
        //sumExpensesByCategory()
    }

    @IBAction func tappedShowGraphScreen(_ sender: UIButton) {
        let vc: CategoriesGraphScreen? = UIStoryboard(name: "CategoriesGraphScreen", bundle: nil).instantiateViewController(withIdentifier: "CategoriesGraphScreen") as? CategoriesGraphScreen
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }

    @IBAction func tappedHideNumbersButton(_ sender: UIButton) {
        hideNumers()
    }
    
    func hideNumers(){
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
    
    public func updateLabels() {
        
        
        let balance = viewModel.updateBalance()

        incomeLabel.text = String(format: "%.2f", balance.incomesTotal)
        expensesLabel.text = String(format: "%.2f", balance.expensesTotal)
        balanceLabel.text = String(format: "%.2f", balance.total)
        
        if balance.total > 0 {
            backgroundBalanceView.backgroundColor = UIColor(named: "PositiveBalance")
        } else if balance.total < 0 {
                backgroundBalanceView.backgroundColor = UIColor(named: "NegativeBalance")
            } else {
                backgroundBalanceView.backgroundColor = UIColor(named: "GreyInformations")
            }
    }
        
    
    
    
}


