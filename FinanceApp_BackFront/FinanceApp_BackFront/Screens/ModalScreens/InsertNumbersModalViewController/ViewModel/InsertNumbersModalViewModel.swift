//
//  insertNumbersModalViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 14/06/23.
//

import Foundation

class InsertNumbersModalViewModel {

    var expression: String = insertNumberStrings.number0
    
    init(amount: Double) {
        self.expression = setValueToExpression(amount)
    }
    
    public func insertNumber(_ char: String) -> String {
        
        if expression == insertNumberStrings.number0 {
            expression = char
        } else {
            expression += char
        }
        return expression
    }
    public func insertPoint() -> String {
        if !expression.contains(insertNumberStrings.point) {
            expression += insertNumberStrings.point
        }
        return expression
    }
    
    public func insertOperator(_ oper: Character) -> String {
        if expression.count > 2 {
            let string = expression.dropLast(1)
            if let _ = string.range(of: insertNumberStrings.operators, options: .regularExpression) {
                expression = String(calculateExpression())
                expression += String(oper)
                return expression
            }
        }
        
        if let lastChar = expression.last, insertNumberStrings.operators.contains(lastChar) {
            expression.removeLast()
        }

        expression += String(oper)
        return expression
    }
    
    public func calculateExpression() -> Double {
       
        if checkOperations(expression) {
            let operators: Set<Character> = [
                insertNumberStrings.operationAdd,
                insertNumberStrings.operationSub,
                insertNumberStrings.operationMult,
                insertNumberStrings.operationDiv
            ]
            var result: Double = 0.0
            
            for (index, character) in expression.enumerated() {
                if operators.contains(character) && index > 0 {
                    let numberBeforeOperator = Double(expression.prefix(index)) ?? 0
                    if let numberAfterOperator = Double(expression.suffix(from: expression.index(after: expression.index(expression.startIndex, offsetBy: index)))) {
                        switch character {
                        case insertNumberStrings.operationAdd:
                            result = numberBeforeOperator + numberAfterOperator
                        case insertNumberStrings.operationSub:
                            result = numberBeforeOperator - numberAfterOperator
                        case insertNumberStrings.operationMult:
                            result = numberBeforeOperator * numberAfterOperator
                        case insertNumberStrings.operationDiv:
                            if numberAfterOperator != 0 {
                                result = numberBeforeOperator / numberAfterOperator
                            } else {
                                result = numberBeforeOperator
                            }
                        default:
                            return 0
                        }
                        expression = setValueToExpression(result)
                    } else {
                        result = numberBeforeOperator
                    }
                }
            }
            return result
        } else {
            return Double(expression) ?? 0.0
        }
    }
    
    public func eraseChar() -> String {
        if expression.count > 0 {
            expression.removeLast()
        }
        
        if expression.isEmpty {
            expression = insertNumberStrings.number0
        }
        return expression
    }
    
    public func checkOperations(_ text: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: insertNumberStrings.regexPattern, options: [])
        let range = NSRange(text.startIndex ..< text.endIndex, in: text)
        let isMatch = regex.firstMatch(in: text, options: [], range: range) != nil
        return isMatch
    }
    
    public func setValueToExpression(_ value: Double) -> String {
        var amount: String = String(value)
        if amount.hasSuffix(insertNumberStrings.decimal0) {
            amount = String(amount.dropLast(2))
        }
        return amount
    }
}
