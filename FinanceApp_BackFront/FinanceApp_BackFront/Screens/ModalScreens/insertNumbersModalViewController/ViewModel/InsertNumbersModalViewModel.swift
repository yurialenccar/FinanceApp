//
//  insertNumbersModalViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 14/06/23.
//

import Foundation

class InsertNumbersModalViewModel {

    var expression: String = "0"
    
    init(amount: Double) {
        self.expression = setValueToExpression(amount)
    }
    
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
                expression = String(calculateExpression())
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
    
    public func calculateExpression() -> Double {
       
        if checkOperations(expression) {
            let operators: Set<Character> = ["+", "-", "x", "÷"]
            var result: Double = 0.0
            
            for (index, character) in expression.enumerated() {
                if operators.contains(character) && index > 0 {
                    let numberBeforeOperator = Double(expression.prefix(index)) ?? 0
                    let numberAfterOperator = Double(expression.suffix(from: expression.index(after: expression.index(expression.startIndex, offsetBy: index)))) ?? 0
                    
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
                        } else {
                            result = numberBeforeOperator
                        }
                    default:
                        return 0
                    }
                    expression = setValueToExpression(result)
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
            expression = "0"
        }
        return expression
    }
    
    public func checkOperations(_ text: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[+\\-x÷]", options: [])
        let range = NSRange(text.startIndex ..< text.endIndex, in: text)
        let isMatch = regex.firstMatch(in: text, options: [], range: range) != nil
        return isMatch
    }
    
    public func setValueToExpression(_ value: Double) -> String {
        var amount: String = String(value)
        if amount.hasSuffix(".0") {
            amount = String(amount.dropLast(2))
        }
        return amount
    }
}
