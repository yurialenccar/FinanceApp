//
//  Tela_Inicio.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//


import UIKit
import Charts

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var hideInformationsButton: UIButton!
    @IBOutlet weak var balancesCollectionView: UICollectionView!
    
    static let identifier:String = String(describing: HomeViewController.self)
    var  viewModel : HomeViewModel = HomeViewModel()
    var informationsHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        setupBalancesCollectionView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
//        updateLabels()
        
    }

    @IBAction func tappedShowGraphScreen(_ sender: UIButton) {
        let vc: CategoriesGraphViewController? = UIStoryboard(name: CategoriesGraphViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: CategoriesGraphViewController.identifier) as? CategoriesGraphViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }

    @IBAction func tappedHideNumbersButton(_ sender: UIButton) {
        hideNumers()
    }
    
    func setupBalancesCollectionView(){
        balancesCollectionView.delegate = self
        balancesCollectionView.dataSource = self
        if let layout = balancesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 17, right: 10)
        }
        balancesCollectionView.backgroundColor = .none
        balancesCollectionView.showsHorizontalScrollIndicator = false
        balancesCollectionView.register(resumeBalanceCollectionViewCell.nib(), forCellWithReuseIdentifier: resumeBalanceCollectionViewCell.identifier)
    }
    
    
    
    func hideNumers(){
        if informationsHidden == false {
            informationsHidden = true
//            incomeLabel.text = "•••••"
//            expensesLabel.text  = "•••••"
            hideInformationsButton.setImage(UIImage(imageLiteralResourceName: "closed eye"), for: .normal)
        } else {
            informationsHidden = false
//            updateLabels()
            hideInformationsButton.setImage(UIImage(imageLiteralResourceName: "eye"), for: .normal)
        }
    }
    
//    public func updateLabels() {
//        let balance = viewModel.updateBalance()
//
//        incomeLabel.text = String(format: "%.2f", balance.incomesTotal)
//        expensesLabel.text = String(format: "%.2f", balance.expensesTotal)
//        balanceLabel.text = String(format: "%.2f", balance.total)
//
//        if balance.total > 0 {
//            backgroundBalanceView.backgroundColor = UIColor(named: "PositiveBalance")
//        } else if balance.total < 0 {
//                backgroundBalanceView.backgroundColor = UIColor(named: "NegativeBalance")
//            } else {
//                backgroundBalanceView.backgroundColor = UIColor(named: "GreyInformations")
//            }
//    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resumeBalanceCollectionViewCell.identifier, for: indexPath) as? resumeBalanceCollectionViewCell
        cell?.layer.cornerRadius = 10
        cell?.layer.masksToBounds = true
        cell?.setupCell(balance: viewModel.updateBalance(), cellNumber: indexPath.row)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 150)
    }
    
    
}
