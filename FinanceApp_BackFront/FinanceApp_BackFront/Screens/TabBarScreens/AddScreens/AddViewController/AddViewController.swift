//
//  Add_Tela.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var accountIncomeButton: UIButton!
    @IBOutlet weak var accountExpenseButton: UIButton!
    @IBOutlet weak var cardExpenseButton: UIButton!
    
    static let identifier:String = String(describing: AddViewController.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
    }

    @IBAction func tappedCloseButton(_ sender: UIButton) {
        let vc: HomeViewController? = UIStoryboard(name: HomeViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: HomeViewController.identifier) as? HomeViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedIncomeButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: RegisterIncomeViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: RegisterIncomeViewController.identifier) {coder ->
            RegisterIncomeViewController? in
            return RegisterIncomeViewController(coder: coder, amount: 0)
        }
        present(vc, animated: true)
    }
    
    @IBAction func tappedExpenseButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: RegisterExpenseViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: RegisterExpenseViewController.identifier) {coder ->
            RegisterExpenseViewController? in
            return RegisterExpenseViewController(coder: coder, amount: 0)
        }
        present(vc, animated: true)
    }
    
    @IBAction func tappedCardExpButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: RegisterCardExpenseViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: RegisterCardExpenseViewController.identifier) {coder ->
            RegisterCardExpenseViewController? in
            return RegisterCardExpenseViewController(coder: coder, amount: 0)
        }
        present(vc, animated: true)
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        accountIncomeButton.setTitle(addStrings.accountIncomeButtonTitle, for: .normal)
        accountExpenseButton.setTitle(addStrings.accountExpenseButtonTitle, for: .normal)
        cardExpenseButton.setTitle(addStrings.cardExpenseButtonTitle, for: .normal)
        
    }

    
}
