//
//  MetasVC.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-13.
//

import UIKit

class BankAccountsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier:String = String(describing: BankAccountsViewController.self)
    var viewModel: BankAccountsViewModel = BankAccountsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        titleLabel.text = moreOptionsStrings.accountsText
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
            layout.sectionInset = viewModel.getCollectionEdgeInsets()
        }
        collectionView.register(AccountCollectionViewCell.nib(), forCellWithReuseIdentifier: AccountCollectionViewCell.identifier)
        collectionView.register(NewItemButtonCell.nib(), forCellWithReuseIdentifier: NewItemButtonCell.identifier)
        
    }
}

extension BankAccountsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CreateItemButtonCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getAccountsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  indexPath.row < bankAccountsList.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountCollectionViewCell.identifier, for: indexPath) as? AccountCollectionViewCell
            cell?.layer.cornerRadius = viewModel.getCellCornerRadius()
            cell?.layer.masksToBounds = true
            cell?.setupCell(account: viewModel.getAccount(indexPath.row))
            return cell ?? UICollectionViewCell()
        }

        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewItemButtonCell.identifier, for: indexPath) as? NewItemButtonCell
            cell?.setupCell(buttonText: viewModel.getNewAccountButtonText())
            cell?.delegate = self
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize(viewWidth: view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let storyboard = UIStoryboard(name: EditBankAccountsViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: EditBankAccountsViewController.identifier) {coder -> EditBankAccountsViewController? in
            return EditBankAccountsViewController(coder: coder, indexAccount: indexPath.row, configType: .editExisting)
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func didTappedNewItemButton() {
        let storyboard = UIStoryboard(name: EditBankAccountsViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: EditBankAccountsViewController.identifier) {coder -> EditBankAccountsViewController? in
            return EditBankAccountsViewController(coder: coder, indexAccount: 0, configType: .createNew)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didCreatedBankAccount() {
        collectionView.reloadData()
    }


}
