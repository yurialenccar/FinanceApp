//
//  CreditCardsScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/04/23.
//

import UIKit

class CreditCardsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier:String = String(describing: CreditCardsViewController.self)
    var viewModel: CreditCardsViewModel = CreditCardsViewModel()
    var dataLoaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        viewModel.updateCards {
            self.setupCollectionView()
            self.dataLoaded = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if dataLoaded {
            collectionView.reloadData()
        }
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        titleLabel.text = moreOptionsStrings.creditCardsText
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

extension CreditCardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCardsCount() + 1
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
            return EditCreditCardsViewController(coder: coder, card: self.viewModel.getCard(indexPath.row), indexCard: indexPath.row, configType: .editExisting)
        }
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension CreditCardsViewController: CreateItemButtonCellDelegate, EditCreditCardsViewControllerProtocol {
    
    func didSaveCard(card: CreditCard, indexCard: Int, configType: ConfigType) {
        switch configType {
        case .createNew:
            viewModel.createNewCard(card) {
                self.collectionView.reloadData()
            }
        case .editExisting:
            viewModel.editCard(card: card, indexCard: indexCard){
                self.collectionView.reloadData()
            }
        }
    }
    
    func didTappedNewItemButton() {
        let emptyCard = CreditCard(desc: globalStrings.emptyString, limit: 0.0, bank: .bancoDoBrasil, closingDay: 05, dueDate: 10, standardCard: false, obs: globalStrings.emptyString)
        let storyboard = UIStoryboard(name: EditCreditCardsViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: EditCreditCardsViewController.identifier) {coder -> EditCreditCardsViewController? in
            return EditCreditCardsViewController(coder: coder, card: emptyCard, indexCard: 0, configType: .createNew)
        }
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
