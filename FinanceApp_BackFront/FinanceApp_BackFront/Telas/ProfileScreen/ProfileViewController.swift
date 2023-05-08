//
//  ProfileScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/04/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    static let identifier:String = String(describing: ProfileViewController.self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationController?.isNavigationBarHidden=true
    }
  

}
