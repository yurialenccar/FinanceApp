//
//  Goal.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 25/04/23.
//

import Foundation

struct Goal {
    var desc: String
    var imageName: String
    var savedAmount: Double
    var goalValue: Double
    var targetDate: String
    
    public var daysToDate: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let targetDate = formatter.date(from: targetDate)

        let today = Date()
        let calendar = Calendar.current

        let components = calendar.dateComponents([.day], from: today, to: targetDate!)
        let days = components.day!
        
        return days
    }
    
    public var remainingAmount: Double {
        return goalValue - savedAmount
    }
}
