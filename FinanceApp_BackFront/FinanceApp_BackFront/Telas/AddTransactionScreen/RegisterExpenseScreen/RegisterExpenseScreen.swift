//
//  RegisterExpenseScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 12/04/23.
//

import UIKit

class RegisterExpenseScreen: UIViewController {

    @IBOutlet weak var descTextField: UITextField!
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var obsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedCategoryButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "CategoriesModalScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CategoriesModalScreen") as? CategoriesModalScreen
        if let presentationController = vc?.presentationController as? UISheetPresentationController{
            presentationController.detents = [.medium()]
        }
        
        self.present(vc ?? UIViewController(), animated: true)
        
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
        
        if missingInformations == false {
            transactions.append(newTransaction)
            dismiss(animated: true, completion: nil)
        }
    }
    

    

    

}
