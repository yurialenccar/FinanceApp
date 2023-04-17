//
//  CategoriesModalScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 14/04/23.
//

import UIKit

class CategoriesModalScreen: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoriesModalCell.nib(), forCellReuseIdentifier: CategoriesModalCell.identifier)
    }

    


}

extension CategoriesModalScreen:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listedCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesModalCell", for: indexPath) as! CategoriesModalCell
        cell.setupCell(listedCategories: listedCategories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("you tapped collection cell \(indexPath.row)")
    }
    
}
