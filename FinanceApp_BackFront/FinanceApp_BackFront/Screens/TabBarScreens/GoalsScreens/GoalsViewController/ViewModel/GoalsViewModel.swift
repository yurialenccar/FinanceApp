//
//  GoalsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 28/05/23.
//

import Foundation
import UIKit

class GoalsViewModel {
    
    var service: FirestoreService = FirestoreService(documentName: "goalsList")
    
    var goalsList: [Goal] = [
        Goal(desc: "Geladeira", imageName: "Casa", savedAmount: 2800, goalValue: 3500, targetDate: "15/05/2023"),
        Goal(desc: "Playstation 5", imageName: "Play5", savedAmount: 1500, goalValue: 4000, targetDate: "20/06/2023"),
        Goal(desc: "Nintendo Wii", imageName: "Play5", savedAmount: 0, goalValue: 2000, targetDate: "20/12/2023"),
    ]
    
    public func getGoalsCount() -> Int {
        return goalsList.count 
    }
    
    public func getItemGoal(_ index:Int) -> Goal {
        return goalsList[index]
    }
    
    public func getCellSize(viewWidth:CGFloat) -> CGSize {
        return CGSize (width: viewWidth - 30, height: 124)
    }
    
    public func createNewGoal(_ newGoal: Goal) {
        goalsList.append(newGoal)
        service.addObjectInArray(newGoal)
    }
    
    public func teste() {
        service.addObjectInArray(goalsList[0])
        //service.deleteObjectInArray(documentName: "goalsList", index: 0)
    }
    
}
