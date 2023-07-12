//
//  LoginViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/05/23.
//

import Foundation
import Firebase

class LoginViewModel {
    public func loginUser(email: String, password: String, completion: @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error == nil {
                userLogged = authResult?.user.uid
                completion(loginStrings.loginSuccessMessage)
            } else {
                let errorMessage = self.getLocalizedErrorMessage(for: error)
                userLogged = "user_Error"
                completion(loginStrings.failToLoginErrorMessage + errorMessage)
            }
        }
    }
    
    private func getLocalizedErrorMessage(for error: Error?) -> String {
        if let errorCode = (error as NSError?)?.code {
            switch errorCode {
            case AuthErrorCode.wrongPassword.rawValue:
                return loginStrings.wrongPasswordError
            case AuthErrorCode.userNotFound.rawValue:
                return loginStrings.userNotFoundError
            case AuthErrorCode.invalidEmail.rawValue:
                return loginStrings.invalidEmail
            default:
                return loginStrings.followError + (error?.localizedDescription ?? "")
            }
        } else {
            return loginStrings.followError + (error?.localizedDescription ?? "")
        }
    }
}

var userLogged: String? = "default"
