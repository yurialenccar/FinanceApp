//
//  SplashScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/04/23.
//

import UIKit

class SplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
//            self.performSegue(withIdentifier: "showSelectLoginScreen", sender: nil)
            let vc: MainScreen? = UIStoryboard(name: "MainScreen", bundle: nil).instantiateViewController(withIdentifier: "MainScreen") as? MainScreen
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        }
    }
    


}
