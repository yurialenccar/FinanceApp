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
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        let vc: RegisterScreen? = UIStoryboard(name: "RegisterScreen", bundle: nil).instantiateViewController(withIdentifier: "RegisterScreen") as? RegisterScreen
        self.present(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedEnterButton(_ sender: UIButton) {
        let vc: RegisterScreen? = UIStoryboard(name: "RegisterScreen", bundle: nil).instantiateViewController(withIdentifier: "RegisterScreen") as? RegisterScreen
        self.present(vc ?? UIViewController(), animated: true)
    }
    
}
