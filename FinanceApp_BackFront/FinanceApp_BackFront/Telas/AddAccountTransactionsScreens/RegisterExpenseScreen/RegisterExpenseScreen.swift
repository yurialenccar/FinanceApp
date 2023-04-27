//
//  RegisterExpenseScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 12/04/23.
//

import UIKit

class RegisterExpenseScreen: UIViewController {
    
    var viewModel:AddAccountTransactionsViewModel=AddAccountTransactionsViewModel(type: .expense)
    
    private var indexCategorySelected:Int = 0
    private var indexAccountSelected:Int = 0

    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var categoryBackgroung: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var obsTextField: UITextField!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var accountBackground: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataPicker()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let today = Date()
        dateField.text = viewModel.datePickerChange(date: today)
        
        updateCategoryField(indexCategorySelected)
        updateAccountField(indexAccountSelected)
        
    }
    
    
    @IBAction func tappedCategoryButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "CategoriesModalScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CategoriesModalScreen") {coder -> CategoriesModalScreen? in
            return CategoriesModalScreen(coder: coder, transactionType: .expense)
        }
        vc.delegate = self
        if let presentationController = vc.presentationController as? UISheetPresentationController{
            presentationController.detents = [.medium()]
        }
        self.present(vc, animated: true)
    }
    
    @IBAction func tappedAccountButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "AccountsModalScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AccountsModalScreen") as? AccountsModalScreen
        vc?.delegate = self
        if let presentationController = vc?.presentationController as? UISheetPresentationController{
            presentationController.detents = [.medium()]
        }
        self.present(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        
        if viewModel.stringIsEmpty(text: amountTextField.text ?? ""){
            amountTextField.layer.borderColor = UIColor.red.cgColor
            amountTextField.layer.borderWidth = 1
            showAlert(title: "Opa, esqueceu de informar valor gasto!")
        } else {
            viewModel.setTransactionsValues(
                desc: descTextField.text ?? "",
                amount: amountTextField.text!,
                category: indexCategorySelected,
                account: indexAccountSelected,
                Obs: obsTextField.text ?? ""
            )
            dismiss(animated: true, completion: nil)
        }
    }
    
    func updateCategoryField(_ indexCategory:Int){
        categoryLabel.text = viewModel.getCategoryLabel(indexCategory)
        categoryImage.image = viewModel.getCategoryImageName(indexCategory)
        categoryBackgroung.backgroundColor = viewModel.getCategoryBackgroungColor(indexCategory)
    }
    
    func updateAccountField(_ indexAccount:Int){
        accountLabel.text = viewModel.getAccountLabel(indexAccount)
        bankLabel.text = viewModel.getBankLabelText(indexAccount)
        bankLabel.textColor = viewModel.getBankLabelColor(indexAccount)
        accountBackground.backgroundColor = viewModel.getBankBackColor(indexAccount)
    }
    
    private func setupDataPicker(){
        let datePicker = UIDatePicker ()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange (datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .inline
        dateField.inputView = datePicker
    }
    
    @objc func dateChange (datePicker: UIDatePicker) {
        dateField.text = viewModel.datePickerChange(date: datePicker.date)
        dateField.resignFirstResponder()
    }
    
    private func showAlert (title: String) {
        let alertController = UIAlertController (title: title, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction (title: "Ok", style: .default, handler: nil)
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    

}


extension RegisterExpenseScreen:CategoriesModalScreenDelegate, AccountsModalScreenDelegate {
    func didSelectCategory(_ indexCategory: Int) {
        indexCategorySelected = indexCategory
        updateCategoryField(indexCategorySelected)
    }
    
    func didSelectAccount(_ indexAcccount: Int) {
        indexAccountSelected = indexAcccount
        updateAccountField(indexAccountSelected)
    }
}
