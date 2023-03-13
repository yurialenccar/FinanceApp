//
//  Relatorios.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-12.
//

import UIKit

class Relatorios: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Define an array of data to display in the picker view
    let data = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
    
    
    @IBOutlet weak var Ref_Picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if the pickerView outlet is properly connected
        guard Ref_Picker != nil else {
            fatalError("pickerView outlet is not connected")
        }
        
        // Set the data source and delegate for the picker view
        Ref_Picker.dataSource = self
        Ref_Picker.delegate = self
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}




