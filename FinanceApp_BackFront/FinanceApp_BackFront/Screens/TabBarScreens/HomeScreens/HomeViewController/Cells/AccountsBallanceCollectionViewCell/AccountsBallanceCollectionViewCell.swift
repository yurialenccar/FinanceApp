//
//  AccountsBallanceCollectionViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/05/23.
//

import UIKit

class AccountsBallanceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var accountsTableView: UITableView!
    @IBOutlet weak var totalBalanceTextLabel: UILabel!
    @IBOutlet weak var totalBalanceValueLabel: UILabel!
    
    static let identifier:String = String(describing: AccountsBallanceCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(){
        
    }

}
