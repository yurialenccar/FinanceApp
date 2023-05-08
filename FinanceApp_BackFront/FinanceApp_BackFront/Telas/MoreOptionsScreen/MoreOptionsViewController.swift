//
//  Mais_Tela.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//

import UIKit

class MoreOptionsViewController: UIViewController {
    
    static let identifier:String = String(describing: MoreOptionsViewController.self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func tappedCategoriesButton(_ sender: UIButton) {
        let vc: CategoriesGraphScreen? = UIStoryboard(name: "CategoriesGraphScreen", bundle: nil).instantiateViewController(withIdentifier: "CategoriesGraphScreen") as? CategoriesGraphScreen
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    @IBAction func tappedCurrencyButton(_ sender: UIButton) {
        let vc: CurrencyScreen? = UIStoryboard(name: "CurrencyScreen", bundle: nil).instantiateViewController(withIdentifier: "CurrencyScreen") as? CurrencyScreen
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    @IBAction func tappedProfileButton(_ sender: UIButton) {
        let vc: ProfileScreen? = UIStoryboard(name: "ProfileScreen", bundle: nil).instantiateViewController(withIdentifier: "ProfileScreen") as? ProfileScreen
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    @IBAction func tappedAccountsButton(_ sender: UIButton) {
        let vc: BankAccountsScreen? = UIStoryboard(name: "BankAccountsScreen", bundle: nil).instantiateViewController(withIdentifier: "BankAccountsScreen") as? BankAccountsScreen
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedCreditCardsButton(_ sender: UIButton) {
        let vc: CreditCardsScreen? = UIStoryboard(name: "CreditCardsScreen", bundle: nil).instantiateViewController(withIdentifier: "CreditCardsScreen") as? CreditCardsScreen
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedLogoutButton(_ sender: UIButton) {
        tabBarController?.navigationController?.popViewController(animated: true)
    }
    
    
    
}


