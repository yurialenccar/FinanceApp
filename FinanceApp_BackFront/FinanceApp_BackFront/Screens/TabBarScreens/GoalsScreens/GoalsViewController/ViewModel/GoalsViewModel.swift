//
//  GoalsViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 28/05/23.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class GoalsViewModel {
    
    var service: FirestoreService = FirestoreService(documentName: "goalsList")
    
    var goalsList: [Goal] = []
    
    public func updateGoals(completion: @escaping () -> Void) {
        service.getObjectData(forObjectType: Goal.self) { result in
            switch result {
            case .success(let object):
                self.goalsList = object
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    
    
    public func getGoalsCount() -> Int {
        return goalsList.count 
    }
    
    public func getItemGoal(_ index:Int) -> Goal {
        return goalsList[index]
    }
    
    public func getCellSize(viewWidth:CGFloat) -> CGSize {
        return CGSize (width: viewWidth - 30, height: 124)
    }
    
    public func createNewGoal(_ newGoal: Goal, completion: @escaping () -> Void) {
        service.addObjectInArray(newGoal) { result in
            if result != "Success" {
                print(result)
            }
            completion()
        }
    }
}
