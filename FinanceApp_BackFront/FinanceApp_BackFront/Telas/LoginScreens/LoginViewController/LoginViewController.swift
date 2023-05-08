//
//  LoginScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/04/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    static let identifier:String = String(describing: LoginViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.keyboardType = .emailAddress
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = "" 
    }
    
    
    
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        let vc: RegisterViewController? = UIStoryboard(name: RegisterViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: RegisterViewController.identifier) as? RegisterViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedEnterButton(_ sender: UIButton) {
        if validadeTextField() == true {
            let storyboard:UIStoryboard = UIStoryboard(name: TabBarController.identifier, bundle: nil)
            if let tbc = storyboard.instantiateViewController(withIdentifier:TabBarController.identifier) as? UITabBarController{
                navigationController?.pushViewController(tbc, animated: true)
            }
            
        } else {
            showAlert(title: "Algum dos campos não foram preenchido!")
        }
        
      
    }
    func showAlert(title:String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    func validadeTextField() -> Bool {
            var statusOk = true
            if emailTextField.text == "" {
                statusOk = false
                emailTextField.layer.borderWidth = 1
                emailTextField.layer.borderColor = UIColor.red.cgColor

            }
        
            if passwordTextField.text == "" {
                statusOk =  false
                passwordTextField.layer.borderWidth = 1
                passwordTextField.layer.borderColor = UIColor.red.cgColor
            }

            if statusOk == true {
                return true
            } else {
                return false
            }
    }
    
    
    
}
    extension LoginViewController : UITextFieldDelegate {
        
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            print(#function)
            textField.layer.borderColor = UIColor.blue.cgColor
            textField.layer.borderWidth = 1
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {

        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            print(#function)
           
            if textField.text?.isEmpty ?? true {
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.red.cgColor
            } else {
                textField.layer.borderWidth = 0
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            print(#function)
            textField.resignFirstResponder()
            return true
            
        }
    }
    





