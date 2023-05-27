//
//  ViewController.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 11/04/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    static let identifier:String = String(describing: TabBarController.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
    }
    
    private func setupItems() {
        guard let items = tabBar.items else { return }
        items[0].title = tabBarStrings.homeScreenTitle
        items[1].title = tabBarStrings.transactionsScreenTitle
        items[2].title = tabBarStrings.addScreenTitle
        items[3].title = tabBarStrings.goalsScreenTitle
        items[4].title = tabBarStrings.moreScreenTitle
        
    }



}
