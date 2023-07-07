//
//  RegisterViewModel.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/05/23.
//

import Foundation
import Firebase

class RegisterViewModel {
    
    var serviceFirestore: FirestoreService = FirestoreService(documentName: "bankAccountsList")
    
    public func createUser(email: String, password: String, completion: @escaping (String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                self.loginUser(email: email, password: password) { result in
                    if result {
                        self.serviceFirestore.user = "user_" + (authResult?.user.uid ?? "")
                        self.createDefaultAccount() {
                            completion(registerStrings.registerAndLoginSuccessText)
                        }
                    } else {
                        completion(registerStrings.onlyRegisterSuccessText)
                    }
                }
            } else {
                let errorMessage = self.getLocalizedErrorMessage(for: error)
                completion(registerStrings.failToRegisterErrorMessage + errorMessage)
            }
        }
    }
    
    public func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error == nil {
                userLogged = authResult?.user.uid
                completion(true)
            } else {
                userLogged = "userError"
                completion(false)
            }
        }
    }
    
    private func createDefaultAccount(completion: @escaping () -> Void) {
        let defaultAccount: [BankAccount] = [BankAccount(desc: "Minha Conta", bank: .other, overdraft: 0.0, standardAccount: true, obs: globalStrings.emptyString)]
        serviceFirestore.setArrayObject(defaultAccount) { result in
            if result != "Success" {
                print(result)
            }
            completion()
        }
    }
    
    public func setProfileValues(profile: Profile, completion: @escaping () -> Void) {
        serviceFirestore.setObject(profile, documentName: "profile") {
            completion()
        }
    }
    
    
    private func getLocalizedErrorMessage(for error: Error?) -> String {
        if let errorCode = (error as NSError?)?.code {
            switch errorCode {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                return registerStrings.emailAlreadyInUse
            default:
                return registerStrings.followError + (error?.localizedDescription ?? "")
            }
        } else {
            return registerStrings.followError + (error?.localizedDescription ?? "")
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
