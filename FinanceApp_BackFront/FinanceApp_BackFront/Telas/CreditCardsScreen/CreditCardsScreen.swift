//
//  CreditCardsScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/04/23.
//

import UIKit

class CreditCardsScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationController?.isNavigationBarHidden=true
    }


}
