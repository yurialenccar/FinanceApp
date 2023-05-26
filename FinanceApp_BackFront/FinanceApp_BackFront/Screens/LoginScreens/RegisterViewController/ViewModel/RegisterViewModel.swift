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
                completion("Sucesso Cadastro!")
            } else {
                completion("Falha em realizar cadastro, segue o erro: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    public func checkEmail(email : String) -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    public func checkPassword(password: String) -> Bool {
        return password.count >= 8
    }
    
}
