//
//  RegisterCardExpScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 12/04/23.
//

import UIKit

class RegisterCardExpenseViewController: UIViewController{
    
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var categoryBackgroung: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var obsTextField: UITextField!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    @IBOutlet weak var registerExpenseButton: UIButton!
    
    static let identifier:String = String(describing: RegisterCardExpenseViewController.self)
    var viewModel:RegisterCardExpViewModel = RegisterCardExpViewModel()
    
    private var indexCategorySelected:Int = 0
    private var indexCardSelected:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupDataPicker()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let today = Date()
        dateField.text = viewModel.datePickerChange(date: today)
        
        updateCategoryField(indexCategorySelected)
        updateCardField(indexCardSelected)
        
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
    
    @IBAction func tappedCardButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: CreditCardModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: CreditCardModalViewController.identifier) as? CreditCardModalViewController
        vc?.delegate = self
        if let presentationController = vc?.presentationController as? UISheetPresentationController{
            presentationController.detents = [.medium()]
        }
        self.present(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedRegisterExpenseButton(_ sender: UIButton) {
        if viewModel.stringIsEmpty(text: amountTextField.text ?? ""){
            amountTextField.layer.borderColor = UIColor.red.cgColor
            amountTextField.layer.borderWidth = 1
            showSimpleAlert(title: globalStrings.attention, message: addStrings.forgotExpenseAmountValue)
        } else {
            viewModel.setExpenseValues(
                desc: descTextField.text ?? "",
                amount: amountTextField.text!,
                category: indexCategorySelected,
                card: globalStrings.emptyString,
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
    
    private func updateCategoryField(_ indexCategory:Int){
        categoryLabel.text = viewModel.getCategoryLabel(indexCategory)
        categoryImage.image = viewModel.getCategoryImageName(indexCategory)
        categoryBackgroung.backgroundColor = viewModel.getCategoryBackgroungColor(indexCategory)
    }
    
    private func updateCardField(_ indexCard:Int){
        cardLabel.text = viewModel.getCardLabel(indexCard)
        bankLabel.text = viewModel.getBankLabelText(indexCard)
        bankLabel.font = viewModel.getBankLabelTextFont(indexCard)
        bankLabel.textColor = viewModel.getBankLabelColor(indexCard)
        bankBackground.backgroundColor = viewModel.getBankBackColor(indexCard)
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

//Extensão que busca a escolha do usuário das telas modais de seleção.
extension RegisterCardExpenseViewController:CategoriesModalDelegate, CardModalDelegate {
    func didSelectCategory(_ indexCategory: Int) {
        indexCategorySelected = indexCategory
        updateCategoryField(indexCategorySelected)
    }
    
    func didSelectCard(_ indexCard: Int) {
        indexCardSelected = indexCard
        updateCardField(indexCardSelected)
    }
}

