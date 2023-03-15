//
//  SplashScreenVC.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-13.
//

import UIKit

class SplashScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a gradient layer
        let gradientLayer = CAGradientLayer()

        // Set the gradient frame to be the same as the view's bounds
        gradientLayer.frame = view.bounds

        // Set the colors for the gradient
        let redColor = UIColor(red: 0.0, green: 1, blue: 0.5, alpha: 0.5)
        let yellowColor = UIColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1)
        let greenColor = UIColor(red: 0.48, green: 0.8, blue: 0.7, alpha: 0.8)
        gradientLayer.colors = [redColor.cgColor, yellowColor.cgColor, greenColor.cgColor]

        // Set the direction of the gradient
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0) // top-left corner
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)   // bottom-right corner

        // Add the gradient layer as a sublayer of the view's layer
        view.layer.insertSublayer(gradientLayer, at: 0)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
