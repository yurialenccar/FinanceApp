//
//  AccountsModalScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import UIKit

protocol AccountsModalDelegate: AnyObject {
    func didSelectAccount(_ indexAcccount: Int)
}

class AccountsModalViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    static let identifier:String = String(describing: AccountsModalViewController.self)
    var viewModel:AccountsModalViewModel = AccountsModalViewModel()
    weak var delegate: AccountsModalDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupTableView()
        
    }
    
    private func setupStrings() {
        titleLabel.text = accountsModalStrings.titleText
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountsTableViewCell.nib(), forCellReuseIdentifier: AccountsTableViewCell.identifier)
    }
}

extension AccountsModalViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAccountsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountsTableViewCell.identifier, for: indexPath) as? AccountsTableViewCell
        cell?.setupCell(bankAccount: viewModel.getItemAccount(indexPath.row))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightSize()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectAccount(indexPath.row)
        dismiss(animated: true, completion:  nil)
    }
    
}
