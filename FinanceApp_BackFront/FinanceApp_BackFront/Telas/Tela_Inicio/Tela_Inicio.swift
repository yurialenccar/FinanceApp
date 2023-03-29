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


    }
    

    @IBAction func tappedShowRelatoriosScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "showRelatoriosVC", sender: nil)
    }
}
