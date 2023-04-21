//
//  RegisterExpenseScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 12/04/23.
//

import UIKit

class RegisterExpenseScreen: UIViewController {
    
    private var indexCategorySelected:Int = 0

    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categoryBackgroung: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var obsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateCategoryField(indexCategorySelected)
    }
    
    
    @IBAction func tappedCategoryButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "CategoriesModalScreen", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "CategoriesModalScreen") as? CategoriesModalScreen
        let vc = storyboard.instantiateViewController(identifier: "CategoriesModalScreen") {coder -> CategoriesModalScreen? in
            return CategoriesModalScreen(coder: coder, transactionType: .expense)
        }
        vc.delegate = self
        if let presentationController = vc.presentationController as? UISheetPresentationController{
            presentationController.detents = [.medium()]
        }
        
        self.present(vc, animated: true)
        
    }
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        print("botao pressionado")
        var missingInformations = false
        var newTransaction = Transactions(desc: "Vazio", amount: 1.0, categoryIndex: 0, date: "01/01/2023", type: .expense, account: "", obs: "")
        
        if (stringIsEmpty(text: descTextField.text ?? "")){
            descTextField.layer.borderColor = UIColor.red.cgColor
            descTextField.layer.borderWidth = 1
            missingInformations = true
            
        } else{
            newTransaction.desc=descTextField.text ?? ""
        }
        
        if (stringIsEmpty(text: amountTextField.text ?? "")){
            amountTextField.layer.borderColor = UIColor.red.cgColor
            amountTextField.layer.borderWidth = 1
            missingInformations = true
        } else{
            newTransaction.amount = Double(amountTextField.text ?? "0.0")!
        }
        
        newTransaction.categoryIndex = indexCategorySelected
        
        if missingInformations == false {
            transactions.append(newTransaction)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func updateCategoryField(_ indexCategory:Int){
        categoryLabel.text = expenseCategories[indexCategory].name
        categoryImage.image = UIImage(imageLiteralResourceName: expenseCategories[indexCategory].imageName)
        categoryBackgroung.backgroundColor = expenseCategories[indexCategory].color
    }
    

    

}

extension RegisterExpenseScreen:CategoriesModalScreenDelegate{
    func didSelectCategory(_ indexCategory: Int) {
        indexCategorySelected = indexCategory
        updateCategoryField(indexCategorySelected)
    }
    
    
}
