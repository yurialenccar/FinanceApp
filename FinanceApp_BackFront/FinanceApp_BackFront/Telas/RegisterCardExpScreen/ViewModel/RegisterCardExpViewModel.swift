//
//  RegisterCardExpViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 25/04/23.
//

import Foundation
import UIKit

class RegisterCardExpViewModel{
    
    
    var newExpense = CreditCardExpenses(desc: "Vazio", amount: 1.0, categoryIndex: 0, date: "01/01/2023", cardIndex: 0, obs: "")
    
    var dataSelecionada = Date()
    
    public func setExpenseValues(desc: String, amount:String, category:Int, card:Int, Obs:String){
        
        newExpense.amount = Double(amount)!
        newExpense.categoryIndex = category
        newExpense.cardIndex = card
        newExpense.date = formatDate(date: dataSelecionada)
        newExpense.obs = Obs
        
        if stringIsEmpty(text: desc){
            newExpense.desc = expenseCategories[newExpense.categoryIndex].name
        } else {
            newExpense.desc = desc
        }
        
        creditCardExpenses.append(newExpense)
    }
    
    public func getCategoryLabel(_ indexCategory:Int) -> String {
        return expenseCategories[indexCategory].name
    }
    
    public func getCategoryImageName(_ indexCategory:Int) -> UIImage{
        return UIImage(imageLiteralResourceName: expenseCategories[indexCategory].imageName)
    }
    
    public func getCategoryBackgroungColor(_ indexCategory:Int) -> UIColor{
        return expenseCategories[indexCategory].color
    }
    
    public func getCardLabel(_ indexAccount:Int) -> String{
        return creditCardsList[indexAccount].desc
    }
    
    public func getBankLabelText(_ indexCard:Int) -> String{
        return bankProperties[creditCardsList[indexCard].bank]?.text ?? "banco"
    }
    
    public func getBankLabelTextFont(_ indexCard:Int) -> UIFont{
        let textSize:Int  = bankProperties[creditCardsList[indexCard].bank]?.textSize ?? 17
        return UIFont.systemFont(ofSize: CGFloat(textSize), weight: .bold)
    }
    
    public func getBankLabelColor(_ indexCard:Int) -> UIColor{
        return bankProperties[creditCardsList[indexCard].bank]!.labelBankColor
    }
    
    public func getBankBackColor(_ indexCard:Int) -> UIColor{
        return bankProperties[creditCardsList[indexCard].bank]!.backgroundColor
    }
    
    
    
    private func formatDate(date: Date) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
    
    public func datePickerChange(date: Date) -> String {
        let calendar = Calendar.current
        let today = Date()
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        dataSelecionada = date
        
        switch formatDate(date: dataSelecionada){
        case formatDate(date: today):
            return "Hoje"
        case formatDate(date: yesterday):
            return "Ontem"
        case formatDate(date: tomorrow):
            return "Amanhã"
        default:
            return formatDate(date: date)
        }
    }
    
    public func stringIsEmpty(text:String) -> Bool {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
