//
//  LoginScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/04/23.
//

import UIKit

class LoginScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        let vc: RegisterScreen? = UIStoryboard(name: "RegisterScreen", bundle: nil).instantiateViewController(withIdentifier: "RegisterScreen") as? RegisterScreen
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedEnterButton(_ sender: UIButton) {

        let storyboard:UIStoryboard = UIStoryboard(name: "TabBarController", bundle: nil)
        if let tbc = storyboard.instantiateViewController(withIdentifier:"TabBarController") as? UITabBarController{
            navigationController?.pushViewController(tbc, animated: true)
        }
        
    }
}
