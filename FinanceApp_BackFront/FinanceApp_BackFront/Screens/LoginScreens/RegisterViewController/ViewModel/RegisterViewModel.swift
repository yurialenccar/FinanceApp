//
//  RegisterViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/05/23.
//

import Foundation
import Firebase

class RegisterViewModel {
    
    public func createUser(email: String, password: String, completion: @escaping (String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                completion(registerStrings.registerSuccessMessage)
            } else {
                completion(registerStrings.failToRegisterErrorMessage + (error?.localizedDescription ?? ""))
            }
        }
    }
    
    public func checkEmail(email : String) -> Bool{
        let emailRegex = registerStrings.emailRegexFormat
        let emailPredicate = NSPredicate(format: registerStrings.emailPredicatedFormat, emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    public func checkPassword(password: String) -> Bool {
        return password.count >= 8
    }
    
}
