//
//  RegisterScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/04/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordRepeatTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginScreenButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var viewModel: RegisterViewModel = RegisterViewModel()
    
    static let identifier:String = String(describing: RegisterViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupElements()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        nameTextfield.text = globalStrings.emptyString
        emailTextfield.text = globalStrings.emptyString
        passwordTextfield.text = globalStrings.emptyString
        passwordRepeatTextfield.text = globalStrings.emptyString
    }
    
    @IBAction func tappedCreateButton(_ sender: UIButton) {
        view.endEditing(true)
    
        let email = emailTextfield.text.orEmpty
        let password = passwordTextfield.text.orEmpty
        
        if !checkTextFields() {
            showSimpleAlert(title: globalStrings.attention, message: registerStrings.someEmptyTextFieldMessage)
            return
        }

        if !viewModel.checkEmail(email: email) {
            setErrorInTextField(textField: emailTextfield)
            showSimpleAlert(title: registerStrings.invalidEmailMessage, message: registerStrings.typeEmailAgainMessage)
            return
        }
         
        if !viewModel.checkPassword(password: password) {
            setErrorInTextField(textField: passwordTextfield)
            setErrorInTextField(textField: passwordRepeatTextfield)
            showSimpleAlert(title: registerStrings.invalidPasswordMessage, message: registerStrings.password8CharsMessage)
            return
        }

        if !checkEqualPasswords() {
            showSimpleAlert(title: registerStrings.incompatiblePasswordsMessage, message: registerStrings.differentPasswordsMessage)
            return
        }
        
        viewModel.createUser(email: email, password: password) { resultRegister in
            if resultRegister == registerStrings.registerSuccessText {
                self.showSimpleAlert(title: registerStrings.registerSuccessMessage, message: globalStrings.emptyString) {
                    let storyboard:UIStoryboard = UIStoryboard(name: TabBarController.identifier, bundle: nil)
                    if let tbc = storyboard.instantiateViewController(withIdentifier:TabBarController.identifier) as? UITabBarController{
                        self.present(tbc, animated: true)
                    }
                }
            } else {
                #warning("Código passando direto antes da mensagem de erro!")
                self.showSimpleAlert(title: globalStrings.attention, message: resultRegister)
            }
        }
    }

    @IBAction func tappedLoginButton(_ sender: UIButton) {
        let vc: LoginViewController? = UIStoryboard(name: LoginViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: LoginViewController.identifier) as? LoginViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        nameTextfield.placeholder = registerStrings.namePlaceholderText
        emailTextfield.placeholder = registerStrings.emailPlaceholderText
        passwordTextfield.placeholder = registerStrings.passwordPlaceholderText
        passwordRepeatTextfield.placeholder = registerStrings.passwordRepeatPlaceholderText
        registerButton.setTitle(registerStrings.registerButtonTitle, for: .normal)
        loginScreenButton.setTitle(registerStrings.loginScreenButtonTitle, for: .normal)
    }
    
    private func setupElements() {
        nameTextfield.delegate = self
        nameTextfield.keyboardType = .default
        nameTextfield.layer.cornerRadius = 5
        
        emailTextfield.delegate = self
        emailTextfield.keyboardType = .emailAddress
        emailTextfield.layer.cornerRadius = 5
        
        passwordTextfield.delegate = self
        passwordTextfield.keyboardType = .default
        passwordTextfield.layer.cornerRadius = 5
        passwordTextfield.isSecureTextEntry = true
        
        passwordRepeatTextfield.delegate = self
        passwordRepeatTextfield.keyboardType = .default
        passwordRepeatTextfield.layer.cornerRadius = 5
        passwordRepeatTextfield.isSecureTextEntry = true
        
        let newConstraint = containerView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: 40)
        newConstraint.isActive = true
    }
    
    private func checkTextFields() -> Bool {
        var okStatus: Bool = true
        
        if !checkTextFieldEmpty(nameTextfield) {
            okStatus = false
        }
        
        if !checkTextFieldEmpty(emailTextfield) {
            okStatus = false
        }
        
        if !checkTextFieldEmpty(passwordTextfield) {
            okStatus = false
        }
        
        if !checkTextFieldEmpty(passwordRepeatTextfield) {
            okStatus = false
        }
        
        return okStatus
    }

    private func checkTextFieldEmpty(_ textField: UITextField) -> Bool {
        if textField.text.orEmpty.isEmptyTest() {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.red.cgColor
            return false
        } else {
            return true
        }
    }
    
    private func checkEqualPasswords() -> Bool {
        if passwordTextfield.text != passwordRepeatTextfield.text {
            setErrorInTextField(textField: passwordTextfield)
            setErrorInTextField(textField: passwordRepeatTextfield)
            return false
        } else {
            return true
        }
    }
    
    private func setErrorInTextField(textField:UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
}

extension RegisterViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 1
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
    
    

