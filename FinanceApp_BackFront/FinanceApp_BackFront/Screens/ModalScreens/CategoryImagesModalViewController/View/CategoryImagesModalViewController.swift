//
//  CategoryImagesModalViewController.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 03/07/23.
//

import UIKit

class CategoryImagesModalViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()

    }
    
    private func setupStrings() {
        titleLabel.text = "Selecionar Imagem"
        cancelButton.setTitle("Cancelar", for: .normal)
        selectButton.setTitle("Selecionar", for: .normal)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
        collectionView.register(CategoryImagesCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryImagesCollectionViewCell.identifier)
        
    }

}

extension CategoryImagesModalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 51
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryImagesCollectionViewCell.identifier, for: indexPath) as? CategoryImagesCollectionViewCell
        cell?.setupCell(index: indexPath.row)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
}
