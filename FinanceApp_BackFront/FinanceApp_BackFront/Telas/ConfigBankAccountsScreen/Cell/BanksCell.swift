//
//  BanksCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import UIKit

class BanksCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier:String = String(describing: BanksCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(name:String){
        nameLabel.text = name
    }

   
}
