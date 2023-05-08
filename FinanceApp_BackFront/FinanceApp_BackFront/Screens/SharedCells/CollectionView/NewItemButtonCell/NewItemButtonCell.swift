//
//  NewItemButtonCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import UIKit

protocol CreateItemButtonCellDelegate: AnyObject {
    func didTappedNewItemButton()
}

class NewItemButtonCell: UICollectionViewCell {

    @IBOutlet weak var createItemButton: UIButton!
    
    weak var delegate: CreateItemButtonCellDelegate?

    static let identifier:String = String(describing: NewItemButtonCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func tappedNewItemButton(_ sender: UIButton) {
        delegate?.didTappedNewItemButton()
    }
    
    
    func setupCell(buttonText:String){
        createItemButton.setTitle(buttonText, for: .normal)
    }
}

    
