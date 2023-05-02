//
//  StringIsEmpty.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 01/05/23.
//

import Foundation

public func stringIsEmpty(text:String) -> Bool {
    return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
}
