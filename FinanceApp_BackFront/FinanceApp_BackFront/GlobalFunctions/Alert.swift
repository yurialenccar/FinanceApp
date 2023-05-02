//
//  Alert.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 01/05/23.
//

import Foundation
import UIKit

class Alert{
    var viewController:UIViewController?
    
    init(viewController:UIViewController? = nil){
        self.viewController = viewController
    }
    
    public func showSimpleAlert(title:String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okButton)
        self.viewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    public func showConfirmAlert(title:String, message: String, completion:(() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            completion?()
        }
        alertController.addAction(confirmAction)
        self.viewController?.present(alertController, animated: true)
    }
}


