//
//  Add_Tela.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//

import UIKit

class AddViewController: UIViewController {
    
    static let identifier:String = String(describing: AddViewController.self)

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func tappedIncomeButton(_ sender: UIButton) {
        let vc: RegisterIncomeViewController? = UIStoryboard(name: RegisterIncomeViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: RegisterIncomeViewController.identifier) as? RegisterIncomeViewController
        present(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedExpenseButton(_ sender: UIButton) {
        let vc: RegisterExpenseViewController? = UIStoryboard(name: RegisterExpenseViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: RegisterExpenseViewController.identifier) as? RegisterExpenseViewController
        present(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedCardExpButton(_ sender: UIButton) {
        let vc: RegisterCardExpenseViewController? = UIStoryboard(name: RegisterCardExpenseViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: RegisterCardExpenseViewController.identifier) as? RegisterCardExpenseViewController
        present(vc ?? UIViewController(), animated: true)
    }

    
}
