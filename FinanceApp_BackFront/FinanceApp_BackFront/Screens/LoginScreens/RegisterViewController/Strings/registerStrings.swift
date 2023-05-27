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
    static let failToRegisterErrorMessage = "Falha em realizar cadastro, segue o erro "
    static let emailRegexFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let emailPredicatedFormat = "SELF MATCHES %@"
}
