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
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    
    static let identifier:String = String(describing: RegisterViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        nameTextfield.text = ""
        emailTextfield.text = ""
        passwordTextfield.text = ""
        passwordRepeatTextfield.text = ""
    }
    
    @IBAction func tappedCreateButton(_ sender: UIButton) {
        view.endEditing(true)
    
        let email = emailTextfield.text ?? ""
        let senha = passwordTextfield.text ?? ""
        
        if !checkTextFields() {
            showSimpleAlert(title: "Atenção", message: "Um ou mais campos não foram preenchidos!")
            return
        }
        
        if !checkEmail(email: email) {
            showSimpleAlert(title: "Email inválido", message: "Por favor, digite um email válido")
            return
        }
         
        if !checkPassword(password: senha) {
             showSimpleAlert(title: "Senha inválida", message: "A senha deve ter pelo menos 8 caracteres")
            return
        }
        
        if !checkEqualPasswords() {
            showSimpleAlert(title: "Senhas não compatíveis", message: "A senha e sua cofirmação não coincidem")
            return
        }
        
        let storyboard:UIStoryboard = UIStoryboard(name: TabBarController.identifier, bundle: nil)
        if let tbc = storyboard.instantiateViewController(withIdentifier:TabBarController.identifier) as? UITabBarController{
            present(tbc, animated: true)
        }
        
        
    }

    @IBAction func tappedLoginButton(_ sender: UIButton) {
        let vc: LoginViewController? = UIStoryboard(name: LoginViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: LoginViewController.identifier) as? LoginViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    private func setupTextFields() {
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
    }
    
    private func checkEmail(email : String) -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: email) {
            setErrorInTextField(textField: emailTextfield)
            return false
        } else {
            return true
        }
    }
    
    private func checkPassword(password: String) -> Bool {
        if password.count < 8 {
            setErrorInTextField(textField: passwordTextfield)
            setErrorInTextField(textField: passwordRepeatTextfield)
            return false
        } else {
            return true
        }
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
        if textField.text == "" {
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
    
    

