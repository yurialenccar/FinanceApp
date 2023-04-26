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
}

var goalList: [Goal] = [
    Goal(desc: "Geladeira", imageName: "Casa", savedAmount: 2800, goalValue: 3500, targetDate: "15/05/2023"),
    Goal(desc: "Playstation 5", imageName: "Play5", savedAmount: 1500, goalValue: 4000, targetDate: "20/06/2023"),
    Goal(desc: "Nintendo Wii", imageName: "Play5", savedAmount: 0, goalValue: 2000, targetDate: "20/12/2023"),
]
