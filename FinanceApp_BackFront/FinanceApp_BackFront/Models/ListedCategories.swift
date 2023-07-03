//
//  ListedCategories.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 06/04/23.
//

import Foundation
import UIKit

struct ListedCategories {
    var name: String
    var imageName: String
    var colorIndex: Int
}

var expenseCategories:[ListedCategories] = [
    ListedCategories(name: "Alimentação", imageName: "star", colorIndex: 0),
    ListedCategories(name: "Casa", imageName: "home", colorIndex: 1),
    ListedCategories(name: "Esportes", imageName: "football", colorIndex: 2)
]

var incomeCategories:[ListedCategories] = [
    ListedCategories(name: "Salario", imageName: "star", colorIndex: 3),
    ListedCategories(name: "Seguro Desemprego", imageName: "car", colorIndex: 4),
    ListedCategories(name: "Apostas", imageName: "home", colorIndex: 5)
]

var categoryColors: [Int: UIColor] = [
    0 : UIColor.orange,
    1 : UIColor.blue,
    2 : UIColor.purple,
    3 : UIColor.red,
    4 : UIColor.systemPink,
    5 : UIColor.yellow,
    6 : UIColor.lightGray,
    7 : UIColor.systemBlue,
    8 : UIColor.cyan,
    9 : UIColor.systemGreen,
]
