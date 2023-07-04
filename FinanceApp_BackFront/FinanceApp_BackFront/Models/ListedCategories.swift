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
    ListedCategories(name: "Alimentação", imageName: "image35", colorIndex: 0),
    ListedCategories(name: "Assinaturas", imageName: "image13", colorIndex: 1),
    ListedCategories(name: "Casa", imageName: "image4", colorIndex: 2),
    ListedCategories(name: "Educação", imageName: "image46", colorIndex: 3),
    ListedCategories(name: "Esportes", imageName: "image8", colorIndex: 4),
    ListedCategories(name: "Lazer", imageName: "image3", colorIndex: 5),
    ListedCategories(name: "Serviços", imageName: "image40", colorIndex: 6),
    ListedCategories(name: "Transferências", imageName: "image43", colorIndex: 7),
    ListedCategories(name: "Transporte", imageName: "image0", colorIndex: 8),
    ListedCategories(name: "Vestuario", imageName: "image1", colorIndex: 9),
    ListedCategories(name: "Viagem", imageName: "image21", colorIndex: 10),
    ListedCategories(name: "Outros", imageName: "image37", colorIndex: 11),
]

var incomeCategories:[ListedCategories] = [
    ListedCategories(name: "Salario", imageName: "image7", colorIndex: 0),
    ListedCategories(name: "Seguro Desemprego", imageName: "image15", colorIndex: 1),
    ListedCategories(name: "Transferência", imageName: "image43", colorIndex: 2),
    ListedCategories(name: "Apostas", imageName: "image3", colorIndex: 3),
    ListedCategories(name: "Vendas", imageName: "image11", colorIndex: 4),
    ListedCategories(name: "Outros", imageName: "image37", colorIndex: 5),
]

var categoryColors: [Int: UIColor] = [
    0 : UIColor.orange,
    1 : UIColor.magenta,
    2 : UIColor.systemPurple,
    3 : UIColor.red,
    4 : UIColor.systemPink,
    5 : UIColor.yellow,
    6 : UIColor.lightGray,
    7 : UIColor.systemBlue,
    8 : UIColor.cyan,
    9 : UIColor.systemGreen,
    10 : UIColor.systemRed,
    11 : UIColor.brown,
]
