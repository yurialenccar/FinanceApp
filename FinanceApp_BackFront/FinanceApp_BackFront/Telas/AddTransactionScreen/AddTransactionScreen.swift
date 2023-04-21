//
//  Add_Tela.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//

import UIKit

class AddTransactionScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a gradient layer
    
    }

    @IBAction func tappedIncomeButton(_ sender: UIButton) {
        let vc: RegisterIncomeScreen? = UIStoryboard(name: "RegisterIncomeScreen", bundle: nil).instantiateViewController(withIdentifier: "RegisterIncomeScreen") as? RegisterIncomeScreen
        present(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedExpenseButton(_ sender: UIButton) {
        let vc: RegisterExpenseScreen? = UIStoryboard(name: "RegisterExpenseScreen", bundle: nil).instantiateViewController(withIdentifier: "RegisterExpenseScreen") as? RegisterExpenseScreen
        present(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedCardExpButton(_ sender: UIButton) {
        let vc: RegisterCardExpScreen? = UIStoryboard(name: "RegisterCardExpScreen", bundle: nil).instantiateViewController(withIdentifier: "RegisterCardExpScreen") as? RegisterCardExpScreen
        present(vc ?? UIViewController(), animated: true)
    }

    
}
