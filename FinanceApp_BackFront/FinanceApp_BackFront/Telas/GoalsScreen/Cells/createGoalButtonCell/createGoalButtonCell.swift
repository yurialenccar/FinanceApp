//
//  createGoalButtonCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/04/23.
//

import UIKit

protocol CreateGoalButtonCellDelegate: AnyObject {
    func didTappedNewGoalButton()
}


class createGoalButtonCell: UICollectionViewCell {
    
    weak var delegate: CreateGoalButtonCellDelegate?

    static let identifier:String = String(describing: createGoalButtonCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func tappedNewGoalButton(_ sender: UIButton) {
        print("button nova meta")
        delegate?.didTappedNewGoalButton()
    }
}
