//
//  AccountsBallanceCollectionViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/05/23.
//

import UIKit

class AccountsBallanceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var accountsTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalBalanceTextLabel: UILabel!
    @IBOutlet weak var totalBalanceValueLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView!
    @IBOutlet weak var noAccountsLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    
    static let identifier:String = String(describing: AccountsBallanceCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var bankAccountList: [BankAccount] = []
    var hideInformations: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    private func setupTableView(){
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        accountsTableView.separatorStyle = .none
        accountsTableView.register(AccountsResumeTableViewCell.nib(), forCellReuseIdentifier: AccountsResumeTableViewCell.identifier)
    }
    
    private func noAccountsToShow(noCards: Bool) {
        if noCards {
            accountsTableView.isHidden = true
            totalBalanceTextLabel.isHidden = true
            totalBalanceValueLabel.isHidden = true
            separatorLineView.isHidden = true
            noAccountsLabel.isHidden = false
            createAccountButton.isHidden = false
            
        } else {
            accountsTableView.isHidden = false
            totalBalanceTextLabel.isHidden = false
            totalBalanceValueLabel.isHidden = false
            separatorLineView.isHidden = false
            noAccountsLabel.isHidden = true
            createAccountButton.isHidden = true
        }
    }
    
    public func setupCell(accountsList: [BankAccount], hideInformations: Bool) {
        if accountsList.isEmpty {
            noAccountsToShow(noCards: true)
        } else {
            noAccountsToShow(noCards: false)
            if hideInformations {
                totalBalanceValueLabel.text =  globalStrings.dashHiddenInformation
                totalBalanceValueLabel.textColor = .black
            } else {
                let total:Double = accountsList.reduce(0) { $0 + $1.balance}
                totalBalanceValueLabel.text = total.toStringMoney()
                if total > 0 {
                    totalBalanceValueLabel.textColor = .GreenGeneralIncomes
                } else if total < 0 {
                    totalBalanceValueLabel.textColor = .RedGeneralExpenses
                } else {
                    totalBalanceValueLabel.textColor = .black
                }
            }
            self.bankAccountList = accountsList
            self.hideInformations = hideInformations
            tableViewHeightConstraint.constant = CGFloat(bankAccountsList.count * 60)
            accountsTableView.reloadData()
        }
    }
}

extension AccountsBallanceCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankAccountList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountsResumeTableViewCell.identifier, for: indexPath) as? AccountsResumeTableViewCell
        cell?.setupCell(bankAccount: bankAccountList[indexPath.row], hideInformations: hideInformations)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
