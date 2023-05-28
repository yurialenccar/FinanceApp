//
//  RegisterExpenseScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 12/04/23.
//

import UIKit

class RegisterExpenseViewController: UIViewController {
    
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
    @IBOutlet weak var registerExpenseButton: UIButton!
    
    static let identifier:String = String(describing: RegisterExpenseViewController.self)
    var viewModel:AddAccountTransactionsViewModel=AddAccountTransactionsViewModel(type: .expense)
    
    private var indexCategorySelected:Int = 0
    private var idAccountSelected:String = globalStrings.emptyString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupDataPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let today = Date()
        dateField.text = viewModel.datePickerChange(date: today)
        
        updateCategoryField(indexCategorySelected)
        updateAccountField(viewModel.standardAccountIndex)
        idAccountSelected = viewModel.standardAccountId
    }
    
    
    @IBAction func tappedCategoryButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: CategoriesModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: CategoriesModalViewController.identifier) {coder -> CategoriesModalViewController? in
            return CategoriesModalViewController(coder: coder, transactionType: .expense)
        }
        vc.delegate = self
        if let presentationController = vc.presentationController as? UISheetPresentationController{
            presentationController.detents = [.medium()]
        }
        self.present(vc, animated: true)
    }
    
    @IBAction func tappedAccountButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: AccountsModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: AccountsModalViewController.identifier) as? AccountsModalViewController
        vc?.delegate = self
        if let presentationController = vc?.presentationController as? UISheetPresentationController{
            presentationController.detents = [.medium()]
        }
        self.present(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedRegisterExpenseButton(_ sender: UIButton) {
        
        if stringIsEmpty(text: amountTextField.text ?? ""){
            amountTextField.layer.borderColor = UIColor.red.cgColor
            amountTextField.layer.borderWidth = 1
            showSimpleAlert(title: globalStrings.attention, message: addStrings.forgotExpenseAmountValue)
        } else {
            viewModel.setTransactionsValues(
                desc: descTextField.text ?? "",
                amount: amountTextField.text!,
                category: indexCategorySelected,
                accountId: idAccountSelected,
                Obs: obsTextField.text ?? ""
            )
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        descTextField.placeholder = addStrings.descriptionText
        amountTextField.placeholder = addStrings.valueText
        obsTextField.placeholder = addStrings.observationsText
        registerExpenseButton.setTitle(addStrings.registerTransactionButtonTitle, for: .normal)
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
}


extension RegisterExpenseViewController:CategoriesModalDelegate, AccountsModalDelegate {
    func didSelectCategory(_ indexCategory: Int) {
        indexCategorySelected = indexCategory
        updateCategoryField(indexCategorySelected)
    }
    
    func didSelectAccount(_ indexAccount: Int) {
        updateAccountField(indexAccount)
        idAccountSelected = bankAccountsList[indexAccount].getId()
    }
}
