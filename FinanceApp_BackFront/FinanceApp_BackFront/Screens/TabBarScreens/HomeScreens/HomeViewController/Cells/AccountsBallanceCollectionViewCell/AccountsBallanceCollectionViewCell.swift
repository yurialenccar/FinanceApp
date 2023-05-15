//
//  AccountsBallanceCollectionViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/05/23.
//

import UIKit

class AccountsBallanceCollectionViewCell: UICollectionViewCell {
    
    var hideInformations: Bool = false

    @IBOutlet weak var accountsTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalBalanceTextLabel: UILabel!
    @IBOutlet weak var totalBalanceValueLabel: UILabel!
    
    static let identifier:String = String(describing: AccountsBallanceCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var bankAccountList: [BankAccount] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        tableViewHeightConstraint.constant = CGFloat(bankAccountsList.count * 60)
    }
    
    func setupTableView(){
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        accountsTableView.separatorStyle = .none
        accountsTableView.register(AccountsResumeTableViewCell.nib(), forCellReuseIdentifier: AccountsResumeTableViewCell.identifier)
    }
    
    func setupCell(accountsList: [BankAccount], hideInformations: Bool) {
        
        if hideInformations {
            totalBalanceValueLabel.text =  "---"
            totalBalanceValueLabel.textColor = .black
        } else {
            let total:Double = accountsList.reduce(0) { $0 + $1.balance}
            totalBalanceValueLabel.text = formatMoney(value: total)
            if total > 0 {
                totalBalanceValueLabel.textColor = UIColor(named: "GreenGeneralIncomes")
            } else if total < 0 {
                totalBalanceValueLabel.textColor = UIColor(named: "RedGeneralExpenses")
            } else {
                totalBalanceValueLabel.textColor = .black
            }
        }
        
        accountsTableView.reloadData()
        
        self.bankAccountList = accountsList
        self.hideInformations = hideInformations
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
