//
//  CurrencyScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/04/23.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    static let identifier:String = String(describing: CurrencyViewController.self)

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationController?.isNavigationBarHidden=true
    }

}
