//
//  RegisterScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/04/23.
//

import UIKit

class RegisterScreen: UIViewController {
    
    
    
    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var passwordRepeatTextfield: UITextField!
    
    @IBOutlet weak var registrationButton: UIButton!
    
    @IBOutlet weak var enterButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextfield.keyboardType = .default
        emailTextfield.keyboardType = .emailAddress
        passwordTextfield.keyboardType = .default
        passwordTextfield.isSecureTextEntry = true
        passwordRepeatTextfield.keyboardType = .default
        passwordRepeatTextfield.isSecureTextEntry = true
        
        
        
        nameTextfield.delegate = self
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        passwordRepeatTextfield.delegate = self
        
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        nameTextfield.text = ""
        emailTextfield.text = ""
        passwordTextfield.text = ""
        passwordRepeatTextfield.text = ""
    }
    
    @IBAction func tappedCreateButton(_ sender: UIButton) {
        
        let email = emailTextfield.text ?? ""
        let senha = passwordTextfield.text ?? ""
        
        if !validarEmail(email: email) {
             let alert = UIAlertController(title: "Email inválido", message: "Por favor, digite um email válido", preferredStyle: .alert)
             let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
             alert.addAction(okAction)
             present(alert, animated: true, completion: nil)
             return
         }
         
         if !ValidarPassword(password: senha) {
             let alert = UIAlertController(title: "Senha inválida", message: "A senha deve ter pelo menos 8 caracteres", preferredStyle: .alert)
             let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
             alert.addAction(okAction)
             present(alert, animated: true, completion: nil)
             return
         }
         
 

        
        if validadeTextFiel() == true {
            
            let storyboard:UIStoryboard = UIStoryboard(name: "TabBarController", bundle: nil)
            if let tbc = storyboard.instantiateViewController(withIdentifier:"TabBarController") as? UITabBarController{
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
    
    
    
    func validadeTextFiel() -> Bool {
        var statusOk = true
        if nameTextfield.text == "" {
            statusOk = false
            nameTextfield.layer.borderWidth = 1
            nameTextfield.layer.borderColor = UIColor.red.cgColor
            
        }
    
        if emailTextfield.text == "" {
            statusOk =  false
            emailTextfield.layer.borderWidth = 1
            emailTextfield.layer.borderColor = UIColor.red.cgColor
        }

        if passwordTextfield.text == "" {
            statusOk =  false
            passwordTextfield.layer.borderWidth = 1
            passwordTextfield.layer.borderColor = UIColor.red.cgColor
        }
        
        if passwordRepeatTextfield.text == "" {
            statusOk =  false
            passwordRepeatTextfield.layer.borderWidth = 1
            passwordRepeatTextfield.layer.borderColor = UIColor.red.cgColor
        }
        if passwordTextfield.text != passwordRepeatTextfield.text {
            statusOk = false
            passwordTextfield.layer.borderWidth = 1
            passwordTextfield.layer.borderColor = UIColor.red.cgColor
            passwordRepeatTextfield.layer.borderWidth = 1
            passwordRepeatTextfield.layer.borderColor = UIColor.red.cgColor
            
            let alertController = UIAlertController(title: "Senhas não compatíveis", message: "A senha e a cofirmação da senha devem ser iguias", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
            }
       
        if statusOk == true {
            return true
        } else {
            return false
        }
    }
    

    
    @IBAction func tappedLoginButton(_ sender: UIButton) {
    
        let vc: LoginScreen? = UIStoryboard(name: "LoginScreen", bundle: nil).instantiateViewController(withIdentifier: "LoginScreen") as? LoginScreen
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    

}

extension RegisterScreen : UITextFieldDelegate {
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
        textField.resignFirstResponder() //serve para abaixar o teclado
        return true
        
    }
    
    func validarEmail(email : String) -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
        
        }
    func ValidarPassword(password: String) -> Bool {
      
        return password.count >= 8
    }

    
}
    
    

