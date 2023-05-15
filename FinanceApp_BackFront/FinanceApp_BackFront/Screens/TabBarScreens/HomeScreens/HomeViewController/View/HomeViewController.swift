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
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    @IBOutlet weak var verticalCollectionView: UICollectionView!
    
    static let identifier:String = String(describing: HomeViewController.self)
    var  viewModel : HomeViewModel = HomeViewModel()
    var informationsHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        viewModel.confirmAllAccountsIDs()
        viewModel.confirmAllCardsIDs()
        setupHorizontalCollectionView()
        setupVerticalCollectionView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
//        updateLabels()
        horizontalCollectionView.reloadData()
        setupVerticalCollectionView()
        verticalCollectionView.reloadData()
    }

    @IBAction func tappedShowGraphScreen(_ sender: UIButton) {
        let vc: CategoriesGraphViewController? = UIStoryboard(name: CategoriesGraphViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: CategoriesGraphViewController.identifier) as? CategoriesGraphViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }

    @IBAction func tappedHideNumbersButton(_ sender: UIButton) {
        hideNumers()
    }
    
    func setupHorizontalCollectionView(){
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        if let layout = horizontalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom:0, right: 15)
        }
        horizontalCollectionView.backgroundColor = .none
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        horizontalCollectionView.register(resumeBalanceCollectionViewCell.nib(), forCellWithReuseIdentifier: resumeBalanceCollectionViewCell.identifier)
    }
    
    func setupVerticalCollectionView(){
        verticalCollectionView.delegate = self
        verticalCollectionView.dataSource = self
        if let layout = verticalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        }
        verticalCollectionView.backgroundColor = UIColor(named: "BackgroundColor")
        verticalCollectionView.showsVerticalScrollIndicator = false
        verticalCollectionView.register(TitleHeaderCollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        verticalCollectionView.register(AccountsBallanceCollectionViewCell.nib(), forCellWithReuseIdentifier: AccountsBallanceCollectionViewCell.identifier)
        verticalCollectionView.register(CardsBallanceCollectionViewCell.nib(), forCellWithReuseIdentifier: CardsBallanceCollectionViewCell.identifier)
        verticalCollectionView.register(TransactionsCollectionViewCell.nib(), forCellWithReuseIdentifier: TransactionsCollectionViewCell.identifier)
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case horizontalCollectionView:
            return 1
        case verticalCollectionView:
            return 3
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case horizontalCollectionView:
            return 3
        case verticalCollectionView:
            if section <= 1 {
                return 1
            } else {
                let maxVisibleTransactions = 4
                return min(transactions.count, maxVisibleTransactions)
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == horizontalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resumeBalanceCollectionViewCell.identifier, for: indexPath) as? resumeBalanceCollectionViewCell
            cell?.layer.cornerRadius = 10
            cell?.layer.masksToBounds = true
            cell?.setupCell(balance: viewModel.updateBalance(), cellNumber: indexPath.row)
            return cell ?? UICollectionViewCell()
        } else {
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountsBallanceCollectionViewCell.identifier, for: indexPath) as? AccountsBallanceCollectionViewCell
                cell?.setupCell(accountsList: bankAccountsList)
                cell?.layer.cornerRadius = 10
                cell?.layer.masksToBounds = true
                return cell ?? UICollectionViewCell()
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardsBallanceCollectionViewCell.identifier, for: indexPath) as? CardsBallanceCollectionViewCell
                cell?.setupCell(cardsList: creditCardsList)
                cell?.layer.cornerRadius = 10
                cell?.layer.masksToBounds = true
                return cell ?? UICollectionViewCell()
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionsCollectionViewCell.identifier, for: indexPath) as! TransactionsCollectionViewCell
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                cell.setup(with: transactions[indexPath.row])
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horizontalCollectionView{
            return CGSize(width: 250, height: 150)
        } else {
            switch indexPath.section {
            case 0:
                return CGSize(width: Int(view.frame.width) - 30, height: (60 + bankAccountsList.count * 60))
            case 1:
                return CGSize(width: Int(view.frame.width) - 30, height: (60 + creditCardsList.count * 60))
            case 2:
                return CGSize(width: Int(view.frame.width) - 30, height: 85)
            default:
                return CGSize(width: view.frame.width - 30, height: 50)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var title:String
            
            if collectionView == verticalCollectionView {
                if kind == UICollectionView.elementKindSectionHeader {
                    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as? TitleHeaderCollectionReusableView
                    switch indexPath.section {
                    case 0:
                        title = "Contas Bancarias"
                    case 1:
                        title = "Cartões de Crédito"
                    case 2:
                        title = "Ultimas Transações"
                    default:
                        title = ""
                    }
                    headerView?.setupCell(title: title)
                    return headerView ?? UICollectionReusableView()
                }
            }
            return UICollectionReusableView()
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            if collectionView == verticalCollectionView {
                return CGSize(width: collectionView.frame.width, height: 50) // Altura do cabeçalho da seção
            }
            return CGSize()
        }
    
}
