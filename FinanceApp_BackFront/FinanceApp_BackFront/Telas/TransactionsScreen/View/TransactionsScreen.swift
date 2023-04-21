//
//  Registros.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 29/03/23.
//

import UIKit

class TransactionsScreen: UIViewController {

    @IBOutlet weak var transactionsCollectionView: UICollectionView!
    
    private var viewModel : TransactionsViewModel = TransactionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        transactionsCollectionView.delegate = self
        transactionsCollectionView.dataSource = self
        transactionsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        transactionsCollectionView.register(TransactionsCollectionViewCell.nib(), forCellWithReuseIdentifier: TransactionsCollectionViewCell.identifier)
    }

}

extension TransactionsScreen: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of itens in section")
        return viewModel.getTransactionsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionsCollectionViewCell.identifier, for: indexPath) as! TransactionsCollectionViewCell
        
        cell.setup(with: viewModel.getItemTransactions(indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize()
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        transactionsCollectionView.deselectItem(at: indexPath, animated: true)
//        print("you tapped collection cell \(indexPath.row)")
//    }
}

