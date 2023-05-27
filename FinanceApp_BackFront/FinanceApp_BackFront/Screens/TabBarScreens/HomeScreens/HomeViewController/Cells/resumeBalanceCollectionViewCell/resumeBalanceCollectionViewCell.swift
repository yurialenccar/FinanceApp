//
//  resumeBalanceCollectionViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/05/23.
//

import UIKit

class resumeBalanceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier:String = String(describing: resumeBalanceCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(balance:BalanceCards){
        titleLabel.text = balance.desc
        if balance.desc == "Total" {
            typeImage.image = UIImage(systemName: balance.symbolImageName)
            //typeImage.image?.renderingMode = .alwaysTemplate
            typeImage.tintColor = .white
        } else {
            typeImage.image = UIImage(imageLiteralResourceName: balance.symbolImageName)
        }
        
        if balance.hideInformations == true {
            valueLabel.text = globalStrings.circleHiddenInformation
        } else {
            valueLabel.text = balance.balance.toStringMoney()
        }
        backgroundColor = UIColor(named: balance.backgroundColorName)
        dateLabel.text = balance.lastTransaction
    }

}
