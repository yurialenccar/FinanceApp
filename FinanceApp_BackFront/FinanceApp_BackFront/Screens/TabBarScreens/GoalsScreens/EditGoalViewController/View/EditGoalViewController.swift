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
    
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var initialAmountContainerView: UIView!
    @IBOutlet weak var initialAmountTextLabel: UILabel!
    @IBOutlet weak var initialAmountValueLabel: UILabel!
    @IBOutlet weak var targetValueContainerView: UIView!
    @IBOutlet weak var targetValueTextLabel: UILabel!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var targetDateTextField: UITextField!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var createGoalButton: UIButton!
    
    var delegate:GoalSavedDelegate?
    static let identifier:String = String(describing: EditGoalViewController.self)
    var viewModel:EditGoalViewModel=EditGoalViewModel()
    var initialAmountValue: Double = 0.0
    var targetValue: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupElements()
        setupDataPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        let today = Date()
    }
    
    @IBAction func tappedInsertInitialAmountButton(_ sender: UIButton) {
        initialAmountContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        let storyboard = UIStoryboard(name: InsertNumbersModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: InsertNumbersModalViewController.identifier) {coder ->
            InsertNumbersModalViewController? in
            return InsertNumbersModalViewController(coder: coder, value: self.initialAmountValue, id: 0)
        }
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func tappedInsertTargetValueButton(_ sender: UIButton) {
        targetValueContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        let storyboard = UIStoryboard(name: InsertNumbersModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: InsertNumbersModalViewController.identifier) {coder ->
            InsertNumbersModalViewController? in
            return InsertNumbersModalViewController(coder: coder, value: self.targetValue, id: 1)
        }
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func tappedChangeImageButton(_ sender: UIButton) {
        //função de escolha de imagens será criada assim que o conjunto de imagens for definido
    }
    
    @IBAction func tappedCreateGoalButton(_ sender: UIButton) {
        if isMissingInformation() == true {
            showSimpleAlert(title: globalStrings.attention, message: goalStrings.missingInformationsMessage)
        } else if initialAmountValue >= targetValue {
            targetValueContainerView.layer.borderColor = UIColor.red.cgColor
            targetValueContainerView.layer.borderWidth = 1
            showSimpleAlert(title: globalStrings.attention, message: goalStrings.increaseTargetValueMessage)
        } else {
            delegate?.didSavedGoal(Goal(
                desc: descTextField.text.orEmpty,
                imageName: goalStrings.casaText,
                savedAmount: initialAmountValue,
                goalValue: targetValue,
                targetDate: targetDateTextField.text.orEmpty
            ))
            dismiss(animated: true)
        }
    }
    
    private func setupStrings() {
        descTextField.placeholder = goalStrings.descriptionText
        initialAmountTextLabel.text = goalStrings.initialAmountText
        targetValueTextLabel.text = goalStrings.targetValueText
        targetDateTextField.placeholder = goalStrings.targetDateText
        imageLabel.text = goalStrings.imageText
        createGoalButton.setTitle(goalStrings.createGoalButtonTitle, for: .normal)
    }
    
    private func setupElements() {
        initialAmountContainerView.layer.borderWidth = 1
        initialAmountContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        initialAmountContainerView.layer.cornerRadius = 5
        initialAmountContainerView.layer.masksToBounds = true
        
        targetValueContainerView.layer.borderWidth = 1
        targetValueContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        targetValueContainerView.layer.cornerRadius = 5
        targetValueContainerView.layer.masksToBounds = true
        
        imageContainerView.layer.borderWidth = 1
        imageContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        imageContainerView.layer.cornerRadius = 5
        imageContainerView.layer.masksToBounds = true
    }
    
    private func updateInitialAmountValue(_ value: Double) {
        initialAmountValue = value
        initialAmountValueLabel.text = value.toStringMoney()
    }
    
    private func updateTargetValue(_ value: Double) {
        targetValue = value
        targetValueLabel.text = value.toStringMoney()
    }
    
    private func setupDataPicker(){
        let datePicker = UIDatePicker ()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange (datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .inline
        targetDateTextField.inputView = datePicker
    }
    
    @objc func dateChange (datePicker: UIDatePicker) {
        targetDateTextField.text = viewModel.formatDate(date: datePicker.date)
        targetDateTextField.resignFirstResponder()
    }
    
    private func isMissingInformation() -> Bool {
        var missing = false
        
        if descTextField.text.orEmpty.isEmpty {
            descTextField.layer.borderColor = UIColor.red.cgColor
            descTextField.layer.borderWidth = 1
            descTextField.layer.cornerRadius = 5
            missing = true
        }
        
        if targetDateTextField.text.orEmpty.isEmpty {
            targetDateTextField.layer.borderColor = UIColor.red.cgColor
            targetDateTextField.layer.borderWidth = 1
            targetDateTextField.layer.cornerRadius = 5
            missing = true
        }
        return missing
    }
}

extension EditGoalViewController: InsertNumbersModalProtocol {
    func numberSelected(_ value: Double, id: Int) {
        if id == 0 {
            updateInitialAmountValue(value)
        } else if id == 1 {
            updateTargetValue(value)
        }
    }
}
