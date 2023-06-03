//
//  NewGoalViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/04/23.
//

import Foundation

class EditGoalViewModel{
    
    
    
    func createNewGoal(desc:String,imageName:String, savedAmount:Double, goalValue:Double, targetDate:String) -> Goal {
        
        let newGoal: Goal = Goal(
            desc: desc,
            imageName: imageName,
            savedAmount: savedAmount,
            goalValue: goalValue,
            targetDate: targetDate
        )
        return newGoal
        //goalsList.append(newGoal)
    }
}
