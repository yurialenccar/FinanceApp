//
//  Mais_Tela.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//

import UIKit

class MoreOptionsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resourcesLabel: UILabel!
    @IBOutlet weak var accountsButton: UIButton!
    @IBOutlet weak var creditCardsButton: UIButton!
    @IBOutlet weak var expensesPerCategoryButton: UIButton!
    @IBOutlet weak var currencyConverterButton: UIButton!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var currencySelectionButton: UIButton!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    var viewModel: MoreOptionsViewModel = MoreOptionsViewModel()
    
    static let identifier:String = String(describing: MoreOptionsViewController.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func tappedCategoriesButton(_ sender: UIButton) {
        let vc: CategoriesGraphViewController? = UIStoryboard(name: CategoriesGraphViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: CategoriesGraphViewController.identifier) as? CategoriesGraphViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedCurrencyButton(_ sender: UIButton) {
        let vc: CurrencyViewController? = UIStoryboard(name: CurrencyViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: CurrencyViewController.identifier) as? CurrencyViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedProfileButton(_ sender: UIButton) {
        let vc: ProfileViewController? = UIStoryboard(name: ProfileViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: ProfileViewController.identifier) as? ProfileViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedAccountsButton(_ sender: UIButton) {
        let vc: BankAccountsViewController? = UIStoryboard(name: BankAccountsViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: BankAccountsViewController.identifier) as? BankAccountsViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedCreditCardsButton(_ sender: UIButton) {
        let vc: CreditCardsViewController? = UIStoryboard(name: CreditCardsViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: CreditCardsViewController.identifier) as? CreditCardsViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedLogoutButton(_ sender: UIButton) {
        if !viewModel.tryLogoutUser(){
            showSimpleAlert(title: globalStrings.error, message: moreOptionsStrings.failToLogoutMessage)
        }
        dismiss(animated: false)
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        titleLabel.text = moreOptionsStrings.moreOptionsTitle
        resourcesLabel.text = moreOptionsStrings.resourcesText
        accountsButton.setTitle(moreOptionsStrings.accountsText, for: .normal)
        creditCardsButton.setTitle(moreOptionsStrings.creditCardsText, for: .normal)
        expensesPerCategoryButton.setTitle(moreOptionsStrings.expensesPerCategoryText, for: .normal)
        currencyConverterButton.setTitle(moreOptionsStrings.currencyExchangeText, for: .normal)
        settingsLabel.text = moreOptionsStrings.settingsText
        profileButton.setTitle(moreOptionsStrings.profileText, for: .normal)
        currencySelectionButton.setTitle(moreOptionsStrings.currencyText, for: .normal)
        logoutButton.setTitle(moreOptionsStrings.logoutText, for: .normal)
    }
}


