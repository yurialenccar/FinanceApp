//
//  SplashViewController.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 29/03/23.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
            self.performSegue(withIdentifier: "showSelectLoginScreen", sender: nil)
        }
        
    }
    

}
