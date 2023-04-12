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

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){

//            let vc: MainScreen? = UIStoryboard(name: "MainScreen", bundle: nil).instantiateViewController(withIdentifier: "MainScreen") as? MainScreen
//            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
            
            let vc: CategoriesGraphScreen? = UIStoryboard(name: "CategoriesGraphScreen", bundle: nil).instantiateViewController(withIdentifier: "CategoriesGraphScreen") as? CategoriesGraphScreen
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
            
            
        }
    }
    


}
