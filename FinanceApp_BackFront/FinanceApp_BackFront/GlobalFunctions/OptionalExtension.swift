//
//  OptionalExtension.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty:String{
        switch self{
        case .some(let value):
            return value
        case .none:
            return ""
        }
    }
}
