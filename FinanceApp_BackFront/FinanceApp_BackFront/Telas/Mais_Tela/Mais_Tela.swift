//
//  Mais_Tela.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//

import UIKit

class Mais_Tela: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func tappedLogoutButton(_ sender: UIButton) {
        tabBarController?.navigationController?.popViewController(animated: true)
        print("Botao pressionado")
    }
    
}


//import UIKit
//
//
//class Relatorios: UIViewController {
//
////     Define an array of data to display in the picker view
//    let data = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
//
//
//
//    @IBOutlet weak var Ref_Picker: UIPickerView!
//    @IBOutlet var gradientLayer: [UIStackView]!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Gastos por Categoria"
//
//        // Create a gradient layer
//        let gradientLayer = UIStackView()
//
//        // Set the gradient frame to be the same as the view's bounds
//        gradientLayer.frame = view.bounds
//
//        // Set the colors for the gradient
//        let redColor = UIColor(red: 0.0, green: 1, blue: 0.5, alpha: 0.5)
//        let yellowColor = UIColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1)
//        let greenColor = UIColor(red: 0.48, green: 0.8, blue: 0.7, alpha: 0.8)
//
//  // Check if the pickerView outlet is properly connected
//        guard Ref_Picker != nil else {
//            fatalError("pickerView outlet is not connected")
//        }
//
//     // Set the data source and delegate for the picker view
//        Ref_Picker.dataSource = self
//        Ref_Picker.delegate = self
//    }
//
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return data.count
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//     return data[row]
//   }
