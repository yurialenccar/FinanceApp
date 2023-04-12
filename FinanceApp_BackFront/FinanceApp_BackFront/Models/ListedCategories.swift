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
    var image: UIImage
    var color: UIColor
}

let listedCategories:[ListedCategories] = [
    ListedCategories(id: 0, name: "Alimentação", image: UIImage(imageLiteralResourceName: "star"), color: UIColor.yellow),
    ListedCategories(id: 1, name: "Casa", image: UIImage(imageLiteralResourceName: "home"), color: UIColor.blue),
    ListedCategories(id: 2, name: "Esportes", image: UIImage(imageLiteralResourceName: "football"), color: UIColor.purple)
    
]

