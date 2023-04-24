//
//  AccountsModalScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 22/04/23.
//

import UIKit

protocol AccountsModalScreenDelegate: AnyObject {
    func didSelectAccount(_ indexAcccount: Int)
}

class AccountsModalScreen: UIViewController {
    
    var viewModel:AccountsModalViewModel = AccountsModalViewModel()
    weak var delegate: AccountsModalScreenDelegate?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountsTableViewCell.nib(), forCellReuseIdentifier: AccountsTableViewCell.identifier)
    }
}

extension AccountsModalScreen : UITableViewDataSource, UITableViewDelegate {
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
