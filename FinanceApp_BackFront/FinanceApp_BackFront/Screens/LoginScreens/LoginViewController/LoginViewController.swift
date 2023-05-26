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
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    static let identifier:String = String(describing: LoginViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        
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
        view.endEditing(true)
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if validadeTextField() == true {
            viewModel.loginUser(email: email, password: password) { resultLogin in
                if resultLogin == "Sucesso Login" {
                    let storyboard: UIStoryboard = UIStoryboard(name: TabBarController.identifier, bundle: nil)
                    if let tbc = storyboard.instantiateViewController(withIdentifier: TabBarController.identifier) as? UITabBarController {
                        self.present(tbc, animated: false)
                    }
                } else {
                    self.showSimpleAlert(title: "Atenção", message: resultLogin)
                }
            }
        } else {
            self.showSimpleAlert(title: "Atenção", message: "Um ou mais campos não foram preenchidos!")
        }
    }
    
    private func setupTextFields(){
        emailTextField.delegate = self
        emailTextField.keyboardType = .emailAddress
        emailTextField.layer.cornerRadius = 5
        
        passwordTextField.delegate = self
        passwordTextField.keyboardType = .default
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.isSecureTextEntry = true
    }
    
    private func validadeTextField() -> Bool {
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

           return statusOk
    }
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 1
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {

    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderWidth = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}






