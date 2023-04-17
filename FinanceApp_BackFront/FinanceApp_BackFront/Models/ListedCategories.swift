//
//  ListedCategories.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 06/04/23.
//

import Foundation
import UIKit

struct ListedCategories {
    var id : Int
    var name: String
    var imageName: String
    var color: UIColor
    var type:TransactionType
}

let listedCategories:[ListedCategories] = [
    ListedCategories(id: 0, name: "Alimentação", imageName: "star", color: UIColor.yellow, type: .expense),
    ListedCategories(id: 1, name: "Casa", imageName: "home", color: UIColor.blue, type: .expense),
    ListedCategories(id: 2, name: "Esportes", imageName: "football", color: UIColor.purple, type: .expense)
    
]

