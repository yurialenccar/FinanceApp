//
//  NewGoalScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/04/23.
//

import UIKit

protocol GoalSavedDelegate{
    func didSavedGoal()
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
            viewModel.createNewGoal(desc: descTextField.text!, imageName: goalStrings.casaText, savedAmount: Double(initialAmountTextField.text!)!, goalValue: Double(targetValueTextField.text!)!, targetDate: tagetDateTextField.text!)
            delegate?.didSavedGoal()
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
        
        if stringIsEmpty(text: descTextField.text ?? "") {
            descTextField.layer.borderColor = UIColor.red.cgColor
            missing = true
        }
        
        if stringIsEmpty(text: initialAmountTextField.text ?? "") {
            initialAmountTextField.layer.borderColor = UIColor.red.cgColor
            missing = true
        }
        
        if stringIsEmpty(text: targetValueTextField.text ?? "") {
            targetValueTextField.layer.borderColor = UIColor.red.cgColor
            missing = true
        }
        
        if stringIsEmpty(text: tagetDateTextField.text ?? "") {
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
