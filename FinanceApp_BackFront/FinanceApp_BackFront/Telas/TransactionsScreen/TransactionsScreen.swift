//
//  Registros.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 29/03/23.
//

import UIKit

class TransactionsScreen: UIViewController {

    @IBOutlet weak var transactionsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView(){
        transactionsCollectionView.delegate = self
        transactionsCollectionView.dataSource = self
        transactionsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        transactionsCollectionView.register(TransactionsCollectionViewCell.nib(), forCellWithReuseIdentifier: TransactionsCollectionViewCell.identifier)
    }

}

extension TransactionsScreen: UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        transactionsCollectionView.deselectItem(at: indexPath, animated: true)
//        print("you tapped collection cell \(indexPath.row)")
//    }
}

extension TransactionsScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionsCollectionViewCell.identifier, for: indexPath) as! TransactionsCollectionViewCell
        
        cell.setup(with: transactions[indexPath.row])
        return cell
    }
    
    
}

extension TransactionsScreen:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: 361, height: 85)
    }
}
