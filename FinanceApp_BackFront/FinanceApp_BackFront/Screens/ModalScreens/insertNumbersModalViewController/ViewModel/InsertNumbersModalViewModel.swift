//
//  insertNumbersModalViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 14/06/23.
//

import Foundation

class InsertNumbersModalViewModel {

    var expression: String = "0"
    
    public func insertChar(_ char: String) -> String {
        
        if expression == "0" {
            expression = char
        } else {
            expression += char
        }
        return expression
    }
    
    public func insertOperator(_ oper: String) -> String {
        if expression.count > 2 {
            let string = expression.dropLast(1)
            if let _ = string.range(of: "[+-x÷]", options: .regularExpression) {
                expression = calculateExpression() ?? "0"
                expression += oper
                return expression
            }
        }
        
        if let lastChar = expression.last, "+-x÷".contains(lastChar) {
            expression.removeLast()
        }

        expression += oper
        return expression
    }
    
    func calculateExpression() -> String? {
        let operators: Set<Character> = ["+", "-", "x", "÷"]
        
        for (index, character) in expression.enumerated() {
            if operators.contains(character) && index > 0 {

                let numberBeforeOperator = Double(expression.prefix(index)) ?? 0
                let numberAfterOperator = Double(expression.suffix(from: expression.index(after: expression.index(expression.startIndex, offsetBy: index)))) ?? 0
                var result: Double = 0.0
                
                switch character {
                case "+":
                    result = numberBeforeOperator + numberAfterOperator
                case "-":
                    result = numberBeforeOperator - numberAfterOperator
                case "x":
                    result = numberBeforeOperator * numberAfterOperator
                case "÷":
                    if numberAfterOperator != 0 {
                        result = numberBeforeOperator / numberAfterOperator
                    }
                default:
                    return nil
                }
                expression = String(result)
            }
        }
        if expression.hasSuffix(".0") {
            expression = String(expression.dropLast(2))
        }
        return expression
    }
    
    public func eraseChar() -> String {
        if expression.count > 0 {
            expression.removeLast()
        }
        
        if expression.count == 0 {
            expression = "0"
        }
        return expression
    }
}
