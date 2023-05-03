//
//  MetasVC.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-13.
//

import UIKit

class BankAccountsScreen: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
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
            layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        }
        collectionView.register(AccountCollectionViewCell.nib(), forCellWithReuseIdentifier: AccountCollectionViewCell.identifier)
        collectionView.register(NewItemButtonCell.nib(), forCellWithReuseIdentifier: NewItemButtonCell.identifier)
        
    }
}

extension BankAccountsScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CreateItemButtonCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bankAccountsList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  indexPath.row < bankAccountsList.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountCollectionViewCell.identifier, for: indexPath) as? AccountCollectionViewCell
            cell?.layer.cornerRadius = 10
            cell?.layer.masksToBounds = true
            cell?.setupCell(account: bankAccountsList[indexPath.row])
            return cell ?? UICollectionViewCell()
        }

        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewItemButtonCell.identifier, for: indexPath) as? NewItemButtonCell
            cell?.setupCell(buttonText: "Criar Nova Conta")
            cell?.delegate = self
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let storyboard = UIStoryboard(name: "ConfigBankAccountsScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ConfigBankAccountsScreen") {coder -> ConfigBankAccountsScreen? in
            return ConfigBankAccountsScreen(coder: coder, indexAccount: indexPath.row, configType: .editExisting)
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func didTappedNewItemButton() {
        let storyboard = UIStoryboard(name: "ConfigBankAccountsScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ConfigBankAccountsScreen") {coder -> ConfigBankAccountsScreen? in
            return ConfigBankAccountsScreen(coder: coder, indexAccount: 0, configType: .createNew)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didCreatedBankAccount() {
        collectionView.reloadData()
    }


}
