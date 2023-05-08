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
    
    static let identifier:String = String(describing: RegisterCardExpenseViewController.self)
    var viewModel:RegisterCardExpViewModel = RegisterCardExpViewModel()
    
    private var indexCategorySelected:Int = 0
    private var indexCardSelected:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataPicker()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let today = Date()
        dateField.text = viewModel.datePickerChange(date: today)
        
        updateCategoryField(indexCategorySelected)
        updateCardField(indexCardSelected)
        
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
    
    @IBAction func tappedCardButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "CreditCardModalScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreditCardModalScreen") as? CreditCardModalScreen
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
            viewModel.setExpenseValues(
                desc: descTextField.text ?? "",
                amount: amountTextField.text!,
                category: indexCategorySelected,
                card: indexCardSelected,
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
    
    func updateCardField(_ indexCard:Int){
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
    
    private func showAlert (title: String) {
        let alertController = UIAlertController (title: title, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction (title: "Ok", style: .default, handler: nil)
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    

}

//Extensão que busca a escolha do usuário das telas modais de seleção.
extension RegisterCardExpenseViewController:CategoriesModalScreenDelegate, CardModalScreenDelegate {
    func didSelectCategory(_ indexCategory: Int) {
        indexCategorySelected = indexCategory
        updateCategoryField(indexCategorySelected)
    }
    
    func didSelectCard(_ indexCard: Int) {
        indexCardSelected = indexCard
        updateCardField(indexCardSelected)
    }
}

