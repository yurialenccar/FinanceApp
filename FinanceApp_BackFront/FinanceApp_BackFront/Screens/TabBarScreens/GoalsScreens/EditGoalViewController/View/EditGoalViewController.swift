//
//  NewGoalScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/04/23.
//

import UIKit

protocol GoalSavedDelegate{
    func didSavedGoal(_ newGoal: Goal)
}

class EditGoalViewController: UIViewController {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var initialAmountLabel: UILabel!
    @IBOutlet weak var initialAmountTextField: UITextField!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var targetValueTextField: UITextField!
    @IBOutlet weak var targetDateLabel: UILabel!
    @IBOutlet weak var tagetDateTextField: UITextField!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var createGoalButton: UIButton!
    
    var delegate:GoalSavedDelegate?
    static let identifier:String = String(describing: EditGoalViewController.self)
    var viewModel:EditGoalViewModel=EditGoalViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func tappedChangeImageButton(_ sender: UIButton) {
        //função de escolha de imagens será criada assim que o conjunto de imagens for definido
    }
    
    @IBAction func tappedCreateGoalButton(_ sender: UIButton) {
        if isMissingInformation() == false {
            let newGoal = viewModel.createNewGoal(
                desc: descTextField.text.orEmpty,
                imageName: goalStrings.casaText,
                savedAmount: Double(initialAmountTextField.text.orEmpty) ?? 0.0,
                goalValue: Double(targetValueTextField.text.orEmpty) ?? 0.0,
                targetDate: tagetDateTextField.text.orEmpty
            )
            delegate?.didSavedGoal(newGoal)
            dismiss(animated: true)
        }
    }
    
    private func setupStrings() {
        descLabel.text = goalStrings.descriptionText
        initialAmountLabel.text = goalStrings.initialAmountText
        targetValueLabel.text = goalStrings.targetValueText
        targetDateLabel.text = goalStrings.targetDateText
        imageLabel.text = goalStrings.imageText
        createGoalButton.setTitle(goalStrings.createGoalButtonTitle, for: .normal)
    }
    
    func isMissingInformation() -> Bool {
        var missing = false
        
        if descTextField.text.orEmpty.isEmpty {
            descTextField.layer.borderColor = UIColor.red.cgColor
            missing = true
        }
        
        if initialAmountTextField.text.orEmpty.isEmpty {
            initialAmountTextField.layer.borderColor = UIColor.red.cgColor
            missing = true
        }
        
        if targetValueTextField.text.orEmpty.isEmpty {
            targetValueTextField.layer.borderColor = UIColor.red.cgColor
            missing = true
        }
        
        if tagetDateTextField.text.orEmpty.isEmpty {
            tagetDateTextField.layer.borderColor = UIColor.red.cgColor
            missing = true
        }
        
        if missing == true {
            return true
        } else {
            return false
        }
    }
    

}
