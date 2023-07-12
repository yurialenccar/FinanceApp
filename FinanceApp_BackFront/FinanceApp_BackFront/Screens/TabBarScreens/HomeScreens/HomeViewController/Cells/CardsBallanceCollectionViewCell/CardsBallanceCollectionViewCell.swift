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
    @IBOutlet weak var separatorLineView: UIView!
    @IBOutlet weak var totalInvoiceTextLabel: UILabel!
    @IBOutlet weak var totalInvoiceValueLabel: UILabel!
    @IBOutlet weak var noCardsLabel: UILabel!
    @IBOutlet weak var createCardButton: UIButton!
    
    static let identifier:String = String(describing: CardsBallanceCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var hideInformations: Bool = false
    var creditCardList: [CreditCard] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    private func setupTableView(){
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        cardsTableView.separatorStyle = .none
        cardsTableView.register(CardsResumeTableViewCell.nib(), forCellReuseIdentifier: CardsResumeTableViewCell.identifier)
    }
    
    private func noCardsToShow(noCards: Bool) {
        if noCards {
            cardsTableView.isHidden = true
            totalInvoiceTextLabel.isHidden = true
            totalInvoiceValueLabel.isHidden = true
            separatorLineView.isHidden = true
            noCardsLabel.isHidden = false
            createCardButton.isHidden = false
            
        } else {
            cardsTableView.isHidden = false
            totalInvoiceTextLabel.isHidden = false
            totalInvoiceValueLabel.isHidden = false
            separatorLineView.isHidden = false
            noCardsLabel.isHidden = true
            createCardButton.isHidden = true
        }
    }
    
    public func setupCell(cardsList: [CreditCard], hideInformations: Bool) {
        if cardsList.isEmpty {
            noCardsToShow(noCards: true)
            tableViewHeightConstraint.constant = CGFloat(60)
        } else{
            noCardsToShow(noCards: false)
            if hideInformations {
                totalInvoiceValueLabel.text = globalStrings.dashHiddenInformation
                totalInvoiceValueLabel.textColor = .black
            } else {
                let total:Double = cardsList.reduce(0) { $0 + $1.invoiceTotal}
                totalInvoiceValueLabel.text = total.toStringMoney()
                if total > 0 {
                    totalInvoiceValueLabel.textColor = .GreenGeneralIncomes
                } else if total < 0 {
                    totalInvoiceValueLabel.textColor = .RedGeneralExpenses
                } else {
                    totalInvoiceValueLabel.textColor = .black
                }
            }
                
            self.creditCardList = cardsList
            self.hideInformations = hideInformations
            tableViewHeightConstraint.constant = CGFloat(cardsList.count * 60)
            cardsTableView.reloadData()
        }
        
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
