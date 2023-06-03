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
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoBottomConstraint: NSLayoutConstraint!
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    static let identifier:String = String(describing: LoginViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupElements()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        emailTextField.text = globalStrings.emptyString
        passwordTextField.text = globalStrings.emptyString
    }
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        let vc: RegisterViewController? = UIStoryboard(name: RegisterViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: RegisterViewController.identifier) as? RegisterViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedEnterButton(_ sender: UIButton) {
        view.endEditing(true)
        
        let email = emailTextField.text.orEmpty
        let password = passwordTextField.text.orEmpty
        
        if validadeTextField() == true {
            viewModel.loginUser(email: email, password: password) { resultLogin in
                if resultLogin == loginStrings.loginSuccessMessage {
                    let storyboard: UIStoryboard = UIStoryboard(name: TabBarController.identifier, bundle: nil)
                    if let tbc = storyboard.instantiateViewController(withIdentifier: TabBarController.identifier) as? UITabBarController {
                        self.present(tbc, animated: false)
                    }
                } else {
                    self.showSimpleAlert(title: loginStrings.atention, message: resultLogin)
                }
            }
        } else {
            self.showSimpleAlert(title: loginStrings.atention, message: loginStrings.emptyFieldsErrorMessage)
        }
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        enterButton.setTitle(loginStrings.enterButtonTitle, for: .normal)
        forgetPasswordButton.setTitle(loginStrings.forgotPasswordButtonTitle, for: .normal)
        registerButton.setTitle(loginStrings.registerButtonTitle, for: .normal)
    }
    
    private func setupElements(){
        emailTextField.delegate = self
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.GreyInformations?.cgColor
        emailTextField.keyboardType = .emailAddress
        emailTextField.layer.cornerRadius = 5
        
        passwordTextField.delegate = self
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.GreyInformations?.cgColor
        passwordTextField.keyboardType = .default
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.isSecureTextEntry = true
        
        enterButton.layer.cornerRadius = 10
        enterButton.layer.masksToBounds = true
        
        let newConstraint = containerView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: 40)
        newConstraint.isActive = true
    }
    
    private func validadeTextField() -> Bool {
            var statusOk = true
        
        if emailTextField.text.orEmpty.isEmptyTest() {
                statusOk = false
                emailTextField.layer.borderWidth = 1
                emailTextField.layer.borderColor = UIColor.red.cgColor
            }
        
            if passwordTextField.text.orEmpty.isEmptyTest() {
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
        logoBottomConstraint.constant = 50
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {

    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        logoBottomConstraint.constant = 100
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






