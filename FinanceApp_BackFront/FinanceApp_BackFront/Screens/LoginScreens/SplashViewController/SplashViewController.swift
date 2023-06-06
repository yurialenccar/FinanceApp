//
//  SplashScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/04/23.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    var animationView: LottieAnimationView = .init(name: splashStrings.lottieAnimationName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLottie()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            let vc: MainViewController? = UIStoryboard(name: MainViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        }
    }
    
    private func setupLottie() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.frame = view.frame
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        view.addSubview(animationView)
        animationView.play()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: -100),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            animationView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
