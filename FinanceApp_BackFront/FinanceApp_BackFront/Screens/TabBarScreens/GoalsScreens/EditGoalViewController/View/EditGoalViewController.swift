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
    
    @IBOutlet weak var descLabel: UITextField!
    @IBOutlet weak var initialAmountLabel: UITextField!
    @IBOutlet weak var targetValueLabel: UITextField!
    @IBOutlet weak var tagetDateLabel: UITextField!
    @IBOutlet weak var goalImage: UIImageView!
    
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
            viewModel.createNewGoal(desc: descLabel.text!, imageName: "Casa", savedAmount: Double(initialAmountLabel.text!)!, goalValue: Double(targetValueLabel.text!)!, targetDate: tagetDateLabel.text!)
            delegate?.didSavedGoal()
            dismiss(animated: true)
        }
    }
    
    func isMissingInformation() -> Bool {
        var missing = false
        
        if stringIsEmpty(text: descLabel.text ?? "") {
            descLabel.layer.borderColor = UIColor.red.cgColor
            missing = true
        }
        
        if stringIsEmpty(text: initialAmountLabel.text ?? "") {
            initialAmountLabel.layer.borderColor = UIColor.red.cgColor
            missing = true
        }
        
        if stringIsEmpty(text: targetValueLabel.text ?? "") {
            targetValueLabel.layer.borderColor = UIColor.red.cgColor
            missing = true
        }
        
        if stringIsEmpty(text: tagetDateLabel.text ?? "") {
            tagetDateLabel.layer.borderColor = UIColor.red.cgColor
            missing = true
        }
        
        if missing == true {
            return true
        } else {
            return false
        }
    }
    

}
