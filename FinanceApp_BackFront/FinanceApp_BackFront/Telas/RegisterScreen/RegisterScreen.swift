//
//  RegisterScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/04/23.
//

import UIKit

class RegisterScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
