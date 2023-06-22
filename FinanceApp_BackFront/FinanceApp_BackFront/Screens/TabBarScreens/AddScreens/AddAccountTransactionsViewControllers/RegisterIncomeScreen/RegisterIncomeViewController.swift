//
//  RegisterIncomeScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 12/04/23.
//

import UIKit

class RegisterIncomeViewController: UIViewController {
    
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var categoryBackgroung: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var accountBackground: UIView!
    @IBOutlet weak var obsTextField: UITextField!
    @IBOutlet weak var registerIncomeButton: UIButton!
    
    static let identifier:String = String(describing: RegisterIncomeViewController.self)
    var viewModel:AddAccountTransactionsViewModel=AddAccountTransactionsViewModel(type: .income)
    
    private var indexCategorySelected:Int = 0
    private var idAccountSelected:String = globalStrings.emptyString
    private var amount: Double
    
    init?(coder: NSCoder, amount: Double) {
        self.amount = amount
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError(globalStrings.initError)
    }
    
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
        updateAmountValue(amount)
    }
    
    @IBAction func tappedInsertAmountButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: InsertNumbersModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: InsertNumbersModalViewController.identifier) {coder ->
            InsertNumbersModalViewController? in
            return InsertNumbersModalViewController(coder: coder, amount: self.amount)
        }
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func tappedCategoryButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: CategoriesModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: CategoriesModalViewController.identifier) {coder -> CategoriesModalViewController? in
            return CategoriesModalViewController(coder: coder, transactionType: .income)
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
    
    @IBAction func tappedRegisterIncomeButton(_ sender: UIButton) {

        if amountTextField.text.orEmpty.isEmptyTest() {
            amountTextField.layer.borderColor = UIColor.red.cgColor
            amountTextField.layer.borderWidth = 1
            showSimpleAlert(title: globalStrings.attention, message: addStrings.forgotIncomeAmountValue)
        } else if amount < 0 {
            amountTextField.layer.borderColor = UIColor.red.cgColor
            amountTextField.layer.borderWidth = 1
            showSimpleAlert(title: globalStrings.attention, message: addStrings.forgotIncomeAmountValue)
        } else {
            viewModel.setTransactionsValues(
                desc: descTextField.text.orEmpty,
                amount: amountTextField.text!,
                category: indexCategorySelected,
                accountId: idAccountSelected,
                Obs: obsTextField.text.orEmpty
            )
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        descTextField.placeholder = addStrings.descriptionText
        amountTextField.placeholder = addStrings.valueText
        obsTextField.placeholder = addStrings.observationsText
        registerIncomeButton.setTitle(addStrings.registerTransactionButtonTitle, for: .normal)
    }
    
    private func updateAmountValue(_ value: Double) {
        amount = value
        amountLabel.text = value.toStringMoney()
    }
    
    private func updateCategoryField(_ indexCategory:Int){
        categoryLabel.text = viewModel.getCategoryLabel(indexCategory)
        categoryImage.image = viewModel.getCategoryImageName(indexCategory)
        categoryBackgroung.backgroundColor = viewModel.getCategoryBackgroungColor(indexCategory)
    }
    
    private func updateAccountField(_ indexAccount:Int){
        accountLabel.text = viewModel.getAccountLabel(indexAccount)
        bankLabel.text = viewModel.getBankLabelText(indexAccount)
        bankLabel.font = viewModel.getBankLabelTextFont(indexAccount)
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


extension RegisterIncomeViewController:CategoriesModalDelegate, AccountsModalDelegate {
    func didSelectCategory(_ indexCategory: Int) {
        indexCategorySelected = indexCategory
        updateCategoryField(indexCategorySelected)
    }
    
    func didSelectAccount(_ indexAccount: Int) {
        updateAccountField(indexAccount)
        idAccountSelected = bankAccountsList[indexAccount].getId()
    }
}

extension RegisterIncomeViewController: InsertNumbersModalProtocol {
    func numberSelected(_ value: Double) {
        updateAmountValue(value)
    }
}
