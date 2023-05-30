//
//  Registros.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 29/03/23.
//

import UIKit

class TransactionsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var transactionsCollectionView: UICollectionView!
    
    static let identifier:String = String(describing: TransactionsViewController.self)
    private var viewModel : TransactionsViewModel = TransactionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
//        setupObserver()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        setupCollectionView()
        transactionsCollectionView.reloadData()
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        titleLabel.text = transactionsStrings.title
    }
    
    private func setupCollectionView(){
        transactionsCollectionView.delegate = self
        transactionsCollectionView.dataSource = self

        if let layout = transactionsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        }
        transactionsCollectionView.register(TransactionsCollectionViewCell.nib(), forCellWithReuseIdentifier: TransactionsCollectionViewCell.identifier)
    }
    
//    private func setupObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(getTransactions), name: Notification.Name(notificationNames.getTransactions), object: nil)
//    }
//
//    @objc func getTransactions(notification:NSNotification){
//        if let transactions = notification.object as? [Transactions] {
//            viewModel.setTransactions(transactions: transactions)
//        }
//
//    }

}

extension TransactionsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTransactionsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionsCollectionViewCell.identifier, for: indexPath) as! TransactionsCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.setup(with: viewModel.getItemTransactions(indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize(viewWidth: view.frame.width)
    }
    
}

