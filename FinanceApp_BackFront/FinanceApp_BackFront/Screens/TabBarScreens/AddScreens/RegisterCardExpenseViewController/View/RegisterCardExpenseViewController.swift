//
//  RegisterCardExpScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 12/04/23.
//

import UIKit

class RegisterCardExpenseViewController: UIViewController{
    
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var amountContainerView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var categoryContainerView: UIView!
    @IBOutlet weak var categoryBackgroung: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var obsTextField: UITextField!
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    @IBOutlet weak var registerExpenseButton: UIButton!
    
    static let identifier:String = String(describing: RegisterCardExpenseViewController.self)
    var viewModel:RegisterCardExpViewModel = RegisterCardExpViewModel()
    
    private var indexCategorySelected: Int = 0
    private var idCardSelected: String = globalStrings.emptyString
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
        setupElements()
        setupDataPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let today = Date()
        dateField.text = viewModel.datePickerChange(date: today)
        updateCategoryField(indexCategorySelected)
        updateCardField(viewModel.standardCardIndex)
        idCardSelected = viewModel.standardCardId
        updateAmountValue(amount)
        
    }
    @IBAction func tappedInsertAmountButton(_ sender: UIButton) {
        amountContainerView.layer.borderColor = UIColor.systemGray6.cgColor
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
        if amount == 0 {
            amountContainerView.layer.borderColor = UIColor.red.cgColor
            showSimpleAlert(title: globalStrings.attention, message: addStrings.forgotExpenseAmountValue)
        } else if amount < 0 {
            amountContainerView.layer.borderColor = UIColor.red.cgColor
            showSimpleAlert(title: globalStrings.attention, message: addStrings.amountMustBeHigherThenZero)
        } else {
            viewModel.setExpenseValues(expense: CreditCardExpense(
                desc: descTextField.text.orEmpty,
                amount: -amount,
                categoryIndex: indexCategorySelected,
                date: viewModel.dataSelecionada.toString(format: globalStrings.dateFormat),
                type: .expense,
                cardId: idCardSelected,
                obs: obsTextField.text.orEmpty
            ))
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        descTextField.placeholder = addStrings.descriptionText
        obsTextField.placeholder = addStrings.observationsText
        registerExpenseButton.setTitle(addStrings.registerTransactionButtonTitle, for: .normal)
    }
    
    private func setupElements() {
        amountContainerView.layer.borderWidth = 1
        amountContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        amountContainerView.layer.cornerRadius = 5
        amountContainerView.layer.masksToBounds = true
        
        categoryContainerView.layer.borderWidth = 1
        categoryContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        categoryContainerView.layer.cornerRadius = 5
        categoryContainerView.layer.masksToBounds = true
        
        cardContainerView.layer.borderWidth = 1
        cardContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        cardContainerView.layer.cornerRadius = 5
        cardContainerView.layer.masksToBounds = true
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
extension RegisterCardExpenseViewController:CategoriesModalDelegate, CardModalDelegate, InsertNumbersModalProtocol {
    func didSelectCategory(_ indexCategory: Int) {
        indexCategorySelected = indexCategory
        updateCategoryField(indexCategorySelected)
    }
    
    func didSelectCard(_ indexCard: Int) {
        updateCardField(indexCard)
        idCardSelected = creditCardsList[indexCard].getId()
    }
    
    func numberSelected(_ value: Double) {
        updateAmountValue(value)
    }
}

