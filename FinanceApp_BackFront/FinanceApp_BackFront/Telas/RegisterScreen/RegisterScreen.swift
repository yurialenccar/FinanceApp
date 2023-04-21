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
        
        
        nameTextfield.delegate = self
        emailTextfield.delegate = self
        passwordRepeatTextfield.delegate = self
        
        enterButton.isEnabled = false
        enterButton.setTitleColor(.white.withAlphaComponent(0.4), for: .disabled)
        enterButton.setTitleColor(.white, for: .normal)
        

   
    }
    func validadeTextField () {
        if nameTextfield.text != "" && emailTextfield.text != "" && passwordTextfield.text != "" {
            enterButton.isEnabled = true
        } else {
            enterButton.isEnabled = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func tappedCreateButton(_ sender: UIButton) {
        let storyboard:UIStoryboard = UIStoryboard(name: "TabBarController", bundle: nil)
        if let tbc = storyboard.instantiateViewController(withIdentifier:"TabBarController") as? UITabBarController{
            navigationController?.pushViewController(tbc, animated: true)
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
        if textField.text?.isEmpty ?? true {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderWidth = 0
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        textField.layer.borderWidth = 0
        validadeTextField()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
              textField.resignFirstResponder()
        return true
    }
  
       
    }

  
    
