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
    var color: UIColor
}

var expenseCategories:[ListedCategories] = [
    ListedCategories(name: "Alimentação", imageName: "star", color: UIColor.orange),
    ListedCategories(name: "Casa", imageName: "home", color: UIColor.blue),
    ListedCategories(name: "Esportes", imageName: "football", color: UIColor.purple)
]

var incomeCategories:[ListedCategories] = [
    ListedCategories(name: "Salario", imageName: "star", color: UIColor.red),
    ListedCategories(name: "Seguro Desemprego", imageName: "car", color: UIColor.systemPink),
    ListedCategories(name: "Apostas", imageName: "home", color: UIColor.orange)
]
