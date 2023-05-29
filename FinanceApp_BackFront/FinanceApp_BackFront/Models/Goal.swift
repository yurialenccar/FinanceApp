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
    
    
    
//    var DaysToTargetDate: String {
//
//        let days = daysToDate()
//
//        if days > 1 {
//            return "Data estimada: \(String(describing: targetDate)). Faltam R$ \(goalValue - savedAmount)0 em \(days) dias para bater a meta."
//        } else {
//            return "Data estimada: \(String(describing: targetDate)). Faltam R$ \(goalValue - savedAmount)0 em \(days) dia para bater a meta."
//        }
//    }
    
//    var recommendation:String{
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.minimumFractionDigits = 2
//        formatter.maximumFractionDigits = 2
//
//        let days = daysToDate
//        let months:Double = Double(days)/30
//        let value = formatter.string(for: (goalValue - savedAmount)/months.rounded(.up))
//
//        if months>1.2 {
//            return "Recomendamos que guarde R$ \(value ?? "0,00") por mês para que o objetivo seja alcançado no prazo."
//        } else{
//            return "Recomendamos que guarde o total de R$ \(goalValue - savedAmount)0 ainda nesse mês para que o objetivo seja alcançado no prazo."
//        }
//    }
    
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

var goalsList: [Goal] = [
    Goal(desc: "Geladeira", imageName: "Casa", savedAmount: 2800, goalValue: 3500, targetDate: "15/05/2023"),
    Goal(desc: "Playstation 5", imageName: "Play5", savedAmount: 1500, goalValue: 4000, targetDate: "20/06/2023"),
    Goal(desc: "Nintendo Wii", imageName: "Play5", savedAmount: 0, goalValue: 2000, targetDate: "20/12/2023"),
]
