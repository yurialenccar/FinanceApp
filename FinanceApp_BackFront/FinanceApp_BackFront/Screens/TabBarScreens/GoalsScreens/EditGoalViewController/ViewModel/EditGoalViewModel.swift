//
//  NewGoalViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/04/23.
//

import Foundation

class EditGoalViewModel{
    
    public var dataSelecionada = Date()
    
    public func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = globalStrings.dateFormat
        
        return formatter.string(from: date)
    }

}
