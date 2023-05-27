//
//  SplashScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/04/23.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){

            let vc: MainViewController? = UIStoryboard(name: MainViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
            
            
        }
    }
    


}
