//
//  goalStrings.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 28/05/23.
//

import Foundation

enum goalStrings {
    //GoalsViewController
    static let goalsTitleText = "Metas e Planejamentos"
    static let newGoalButtonTitle = "Criar Nova Meta"
    
    //GoalInfoViewController
    static let goalText = "Meta"
    static let targetDateToGoalText = "Data alvo para alcançar a meta: "
    static let saveAmountButtonTitle = "Guardar valor para Meta"
    
    static func DaysToTargetDate(goal: Goal) -> String {
        let remainingAmount: Double = goal.goalValue - goal.savedAmount
        if goal.daysToDate > 1 {
            return "Faltam \(remainingAmount.toStringMoney()) em \(goal.daysToDate) dias para bater a meta."
        } else if goal.daysToDate == 1 {
            return "Faltam \(remainingAmount.toStringMoney()) em \(goal.daysToDate) dia para bater a meta."
        } else if goal.daysToDate == 0 {
            return "Dia de entrega da meta. Faltam ainda \(remainingAmount.toStringMoney())."
        } else {
            return "Meta atrasada. Faltam ainda \(remainingAmount.toStringMoney())."
        }
    }
    
    static func recommendingText(goal: Goal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let days = goal.daysToDate
        let months:Double = Double(days)/30
        let value = formatter.string(for: goal.remainingAmount/months.rounded(.up))

        if months>1.2 {
            return "Recomendamos que guarde R$ \(value ?? "0,00") por mês para que o objetivo seja alcançado no prazo."
        } else{
            return "Recomendamos que guarde o total de \(goal.remainingAmount.toStringMoney()) ainda nesse mês para que o objetivo seja alcançado no prazo."
        }
    }
    
    
    //EditGoalViewController
    static let createGoalText = "Criar Meta"
    static let descriptionText = "Descrição"
    static let initialAmountText = "Saldo Inicial"
    static let targetValueText = "Valor da Meta"
    static let targetDateText = "Data Alvo"
    static let imageText = "Imagem"
    static let createGoalButtonTitle = "Criar"
    
}
