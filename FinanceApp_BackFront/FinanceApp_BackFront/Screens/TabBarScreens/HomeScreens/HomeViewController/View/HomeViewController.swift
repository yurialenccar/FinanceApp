//
//  Tela_Inicio.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//


import UIKit
import Charts
import Lottie

class HomeViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var helloTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hideInformationsButton: UIButton!
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    @IBOutlet weak var verticalCollectionView: UICollectionView!
    
    static let identifier:String = String(describing: HomeViewController.self)
    var  viewModel : HomeViewModel = HomeViewModel()
    let animationView: LottieAnimationView = .init(name: globalStrings.loadingLottie)
    var hideInformations = false
    var dataLoaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupUIComponents()
        setupObserver()
        setupLottie()
        viewModel.getAllData {
            self.nameLabel.text = Utils.getUserDefaults(key: "userName") as? String ?? globalStrings.error
            self.viewModel.updateBalanceValues()
            self.setupHorizontalCollectionView()
            self.setupVerticalCollectionView()
            self.dataLoaded = true
            self.showData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        if dataLoaded {
            self.nameLabel.text = Utils.getUserDefaults(key: "userName") as? String ?? globalStrings.error
            self.viewModel.updateBalanceValues()
            self.horizontalCollectionView.reloadData()
            self.verticalCollectionView.reloadData()
        }
    }

    @IBAction func tappedShowGraphScreen(_ sender: UIButton) {
        let vc: CategoriesGraphViewController? = UIStoryboard(name: CategoriesGraphViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: CategoriesGraphViewController.identifier) as? CategoriesGraphViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }

    @IBAction func tappedHideNumbersButton(_ sender: UIButton) {
        hideInformations.toggle()
        updateInformationsVisibility(informationsHidden: hideInformations)
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        helloTextLabel.text = homeStrings.helloText
    }
    
    private func setupUIComponents(){
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.clipsToBounds = true
        
        horizontalCollectionView.isHidden = true
        verticalCollectionView.isHidden = true
    }
    
    private func setupHorizontalCollectionView() {
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
    
    private func setupVerticalCollectionView(){
        verticalCollectionView.delegate = self
        verticalCollectionView.dataSource = self
        if let layout = verticalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        }
        verticalCollectionView.backgroundColor = .backgroundColor
        verticalCollectionView.showsVerticalScrollIndicator = false
        verticalCollectionView.register(TitleHeaderCollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        verticalCollectionView.register(AccountsBallanceCollectionViewCell.nib(), forCellWithReuseIdentifier: AccountsBallanceCollectionViewCell.identifier)
        verticalCollectionView.register(CardsBallanceCollectionViewCell.nib(), forCellWithReuseIdentifier: CardsBallanceCollectionViewCell.identifier)
        verticalCollectionView.register(CategoriesGraphCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoriesGraphCollectionViewCell.identifier)
        verticalCollectionView.register(TransactionsCollectionViewCell.nib(), forCellWithReuseIdentifier: TransactionsCollectionViewCell.identifier)
    }
    
    private func setupLottie() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.frame = view.frame
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        view.addSubview(animationView)
        animationView.play()
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
            animationView.heightAnchor.constraint(equalToConstant: 100),
            animationView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func showData() {
        animationView.isHidden = true
        horizontalCollectionView.isHidden = false
        verticalCollectionView.isHidden = false
    }
    
    private func updateInformationsVisibility(informationsHidden: Bool) {
        if informationsHidden == true {
            hideInformationsButton.setImage(.closedEye, for: .normal)
        } else {
            hideInformationsButton.setImage(.eye, for: .normal)
        }
        horizontalCollectionView.reloadData()
        verticalCollectionView.reloadData()
    }
    
    private func setupObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfileImage), name: Notification.Name(rawValue: homeStrings.profileImageUpdatedNotification), object: nil)
    }
    
    @objc func updateProfileImage(notification:NSNotification) {
        profileImage.image = notification.object as? UIImage
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case horizontalCollectionView:
            return 1
        case verticalCollectionView:
            if transactionsList.count > 0 {
                return 4
            } else {
                return 2
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case horizontalCollectionView:
            return 3
        case verticalCollectionView:
            if section <= 2 {
                return 1
            } else {
                let maxVisibleTransactions = 4
                return min(transactionsList.count, maxVisibleTransactions)
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
            cell?.setupCell(card: viewModel.getCardInformation(cardNumber: indexPath.row), hideInformations: self.hideInformations)
            return cell ?? UICollectionViewCell()
        } else {
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountsBallanceCollectionViewCell.identifier, for: indexPath) as? AccountsBallanceCollectionViewCell
                cell?.setupCell(accountsList: bankAccountsList, hideInformations: self.hideInformations)
                cell?.layer.cornerRadius = 10
                cell?.layer.masksToBounds = true
                return cell ?? UICollectionViewCell()
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardsBallanceCollectionViewCell.identifier, for: indexPath) as? CardsBallanceCollectionViewCell
                cell?.setupCell(cardsList: creditCardsList, hideInformations: self.hideInformations)
                cell?.layer.cornerRadius = 10
                cell?.layer.masksToBounds = true
                return cell ?? UICollectionViewCell()
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesGraphCollectionViewCell.identifier, for: indexPath) as? CategoriesGraphCollectionViewCell
                cell?.updateChartData()
                cell?.layer.cornerRadius = 10
                cell?.layer.masksToBounds = true
                return cell ?? UICollectionViewCell()
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionsCollectionViewCell.identifier, for: indexPath) as! TransactionsCollectionViewCell
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                cell.setup(with: transactionsList[indexPath.row])
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
                var height: Int
                if bankAccountsList.isEmpty {
                    height = 110
                } else {
                    height = (60 + bankAccountsList.count * 60)
                }
                return CGSize(width: Int(view.frame.width) - 30, height: height)
            case 1:
                var height: Int
                if creditCardsList.isEmpty {
                    height = 110
                } else {
                    height = (60 + creditCardsList.count * 60)
                }
                return CGSize(width: Int(view.frame.width) - 30, height: height)
            case 2:
                return CGSize(width: Int(view.frame.width) - 30, height: 200)
            case 3:
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
                        title = homeStrings.bankAccountsText
                    case 1:
                        title = homeStrings.creditCardsText
                    case 2:
                        title = homeStrings.expensesPerCategoryText
                    case 3:
                        title = homeStrings.lastTransactionsText
                    default:
                        title = globalStrings.emptyString
                    }
                    headerView?.setupCell(title: title)
                    return headerView ?? UICollectionReusableView()
                }
            }
            return UICollectionReusableView()
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            if collectionView == verticalCollectionView {
                return CGSize(width: collectionView.frame.width, height: 50)
            }
            return CGSize()
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        if indexPath.section == 2 {
            let vc: CategoriesGraphViewController? = UIStoryboard(name: CategoriesGraphViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: CategoriesGraphViewController.identifier) as? CategoriesGraphViewController
            navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        }
    }
}
