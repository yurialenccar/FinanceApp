//
//  MetasVC.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-13.
//

import UIKit

class GoalsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: GoalsViewModel = GoalsViewModel()
    
    static let identifier:String = String(describing: GoalsViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupCollectionView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        titleLabel.text = goalStrings.goalsTitleText
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        }
        collectionView.register(GoalsCollectionViewCell.nib(), forCellWithReuseIdentifier: GoalsCollectionViewCell.identifier)
        collectionView.register(createGoalButtonCell.nib(), forCellWithReuseIdentifier: createGoalButtonCell.identifier)
    }


}

extension GoalsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CreateGoalButtonCellDelegate, GoalSavedDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getGoalsCount() + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  indexPath.row < goalsList.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalsCollectionViewCell.identifier, for: indexPath) as? GoalsCollectionViewCell
            cell?.layer.cornerRadius = 10
            cell?.layer.masksToBounds = true
            cell?.setupCell(goal: viewModel.getItemGoal(indexPath.row))
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createGoalButtonCell.identifier, for: indexPath) as? createGoalButtonCell
            cell?.delegate = self
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize(viewWidth: view.frame.width)
    }
    
    func didTappedNewGoalButton() {
        let storyboard = UIStoryboard(name: EditGoalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: EditGoalViewController.identifier) as? EditGoalViewController
        vc?.delegate = self
        if let presentationController = vc?.presentationController as? UISheetPresentationController{
            presentationController.detents = [.medium()]
        }
        self.present(vc ?? UIViewController(), animated: true)
    }
    
    func didSavedGoal() {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        if indexPath.row < goalsList.count{
            let storyboard = UIStoryboard(name: GoalInfoViewController.identifier, bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: GoalInfoViewController.identifier) {coder -> GoalInfoViewController? in
                return GoalInfoViewController(coder: coder, goal: goalsList[indexPath.row])
            }
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
