//
//  CardsBallanceCollectionViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/05/23.
//

import UIKit

class CardsBallanceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardsTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalInvoiceTextLabel: UILabel!
    @IBOutlet weak var totalInvoiceValueLabel: UILabel!
    
    static let identifier:String = String(describing: CardsBallanceCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var hideInformations: Bool = false
    var creditCardList: [CreditCard] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        tableViewHeightConstraint.constant = CGFloat(bankAccountsList.count * 60)
    }
    
    func setupTableView(){
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        cardsTableView.separatorStyle = .none
        cardsTableView.register(CardsResumeTableViewCell.nib(), forCellReuseIdentifier: CardsResumeTableViewCell.identifier)
    }
    
    func setupCell(cardsList: [CreditCard], hideInformations: Bool) {
        
        if hideInformations {
            totalInvoiceValueLabel.text = "---"
            totalInvoiceValueLabel.textColor = .black
        } else {
            let total:Double = cardsList.reduce(0) { $0 + $1.invoiceTotal}
            totalInvoiceValueLabel.text = formatMoney(value: total)
            if total > 0 {
                totalInvoiceValueLabel.textColor = UIColor(named: "GreenGeneralIncomes")
            } else if total < 0 {
                totalInvoiceValueLabel.textColor = UIColor(named: "RedGeneralExpenses")
            } else {
                totalInvoiceValueLabel.textColor = .black
            }
        }
            
        cardsTableView.reloadData()
        
        self.creditCardList = cardsList
        self.hideInformations = hideInformations
    }
}

extension CardsBallanceCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardsResumeTableViewCell.identifier, for: indexPath) as? CardsResumeTableViewCell
        cell?.setupCell(creditCard: creditCardList[indexPath.row], hideInformations: hideInformations)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
