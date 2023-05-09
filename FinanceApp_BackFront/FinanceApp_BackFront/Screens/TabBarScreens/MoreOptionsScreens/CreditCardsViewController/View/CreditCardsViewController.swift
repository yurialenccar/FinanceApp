//
//  CreditCardsScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/04/23.
//

import UIKit

class CreditCardsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier:String = String(describing: CreditCardsViewController.self)
    var viewModel: CreditCardsViewModel = CreditCardsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
            layout.sectionInset = viewModel.getCollectionEdgeInsets()
        }
        collectionView.register(CreditCardCollectionViewCell.nib(), forCellWithReuseIdentifier: CreditCardCollectionViewCell.identifier)
        collectionView.register(NewItemButtonCell.nib(), forCellWithReuseIdentifier: NewItemButtonCell.identifier)
        
    }
}

extension CreditCardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CreateItemButtonCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCardsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  indexPath.row < creditCardsList.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreditCardCollectionViewCell.identifier, for: indexPath) as? CreditCardCollectionViewCell
            cell?.layer.cornerRadius = viewModel.getCellCornerRadius()
            cell?.layer.masksToBounds = true
            cell?.setupCell(card: viewModel.getCard(indexPath.row))
            return cell ?? UICollectionViewCell()
        }

        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewItemButtonCell.identifier, for: indexPath) as? NewItemButtonCell
            cell?.setupCell(buttonText: viewModel.getNewCardButtonText())
            cell?.delegate = self
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize(viewWidth: view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let storyboard = UIStoryboard(name: EditCreditCardsViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: EditCreditCardsViewController.identifier) {coder -> EditCreditCardsViewController? in
            return EditCreditCardsViewController(coder: coder, indexCard: indexPath.row, configType: .editExisting)
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func didTappedNewItemButton() {
        let storyboard = UIStoryboard(name: EditCreditCardsViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: EditCreditCardsViewController.identifier) {coder -> EditCreditCardsViewController? in
            return EditCreditCardsViewController(coder: coder, indexCard: 0, configType: .createNew)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didCreatedBankAccount() {
        collectionView.reloadData()
    }


}
