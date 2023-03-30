//
//  Tela_Inicio.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//

import UIKit

class Tela_Inicio: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarController?.navigationItem.hidesBackButton = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func tappedShowRelatoriosScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "showRelatoriosVC", sender: nil)
    }
}
