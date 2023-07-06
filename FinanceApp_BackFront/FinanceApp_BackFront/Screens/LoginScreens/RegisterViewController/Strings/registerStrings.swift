//
//  RegisterStrings.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/05/23.
//

import Foundation

enum registerStrings {
    static let namePlaceholderText = "Nome Completo"
    static let emailPlaceholderText = "Email"
    static let passwordPlaceholderText = "Senha"
    static let passwordRepeatPlaceholderText = "Confirmação de Senha"
    static let registerButtonTitle = "Criar Conta"
    static let loginScreenButtonTitle = "Já possuo uma conta"
    
    static let registerSuccessMessage = "Cadastro realizado com sucesso!"
    static let failToRegisterErrorMessage = "Falha em realizar cadastro, "
    static let emailRegexFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let emailPredicatedFormat = "SELF MATCHES %@"
    static let someEmptyTextFieldMessage = "Um ou mais campos não foram preenchidos!"
    static let typeEmailAgainMessage = "Por favor, digite um email válido"
    static let password8CharsMessage = "A senha deve ter pelo menos 8 caracteres"
    static let differentPasswordsMessage = "A senha e sua cofirmação não coincidem"
    static let invalidEmailMessage = "Email inválido"
    static let invalidPasswordMessage = "Senha inválida"
    static let incompatiblePasswordsMessage = "Senhas não compatíveis"
    static let onlyRegisterSuccessText = "Sucesso Cadastro!"
    static let registerAndLoginSuccessText = "Sucesso Cadastro e Login!"
    
    static let emailAlreadyInUse = "email já foi cadastrado no sistema!"
    static let followError = "segue o erro "
}


