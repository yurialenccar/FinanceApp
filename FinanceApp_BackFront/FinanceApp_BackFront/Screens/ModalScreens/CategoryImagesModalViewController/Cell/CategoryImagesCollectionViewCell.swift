//
//  CategoryImagesCollectionViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 03/07/23.
//

import UIKit

class CategoryImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    static let identifier:String = String(describing: CategoryImagesCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    public func setupCell(index: Int) {
        categoryImage.image = UIImage(named: "image" + String(index))
    }

}
