//
//  LoginScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/04/23.
//

import UIKit

class MainScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func tappedLoginButton(_ sender: UIButton) {
        let vc: LoginScreen? = UIStoryboard(name: "LoginScreen", bundle: nil).instantiateViewController(withIdentifier: "LoginScreen") as? LoginScreen
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        let vc: RegisterScreen? = UIStoryboard(name: "RegisterScreen", bundle: nil).instantiateViewController(withIdentifier: "RegisterScreen") as? RegisterScreen
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }


}
