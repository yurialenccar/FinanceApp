//
//  NewGoalViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/04/23.
//

import Foundation

class EditGoalViewModel{
    
    var newGoal:Goal=Goal(desc: "", imageName: "", savedAmount: 0.0, goalValue: 0.0, targetDate: "")
    
    func createNewGoal(desc:String,imageName:String, savedAmount:Double, goalValue:Double, targetDate:String){
        newGoal.desc = desc
        newGoal.imageName = imageName
        newGoal.savedAmount = savedAmount
        newGoal.goalValue = goalValue
        newGoal.targetDate = targetDate
        
        goalsList.append(newGoal)
    }
}
