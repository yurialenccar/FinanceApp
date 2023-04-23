//
//  CategoriesModalScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 14/04/23.
//

import UIKit

protocol CategoriesModalScreenDelegate: AnyObject {
    func didSelectCategory(_ indexCategory: Int)
}


class CategoriesModalScreen: UIViewController {
    
    weak var delegate: CategoriesModalScreenDelegate?
    
    let transactionType:TransactionType
    var filteredCategories:[ListedCategories]
    
    init?(coder:NSCoder, transactionType:TransactionType){
        self.transactionType = transactionType
        if transactionType == .expense {
            self.filteredCategories = expenseCategories
        } else {
            self.filteredCategories = incomeCategories
        }
        super.init(coder: coder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoriesModalCell.nib(), forCellReuseIdentifier: CategoriesModalCell.identifier)
    }

    


}

extension CategoriesModalScreen:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesModalCell", for: indexPath) as! CategoriesModalCell
        cell.setupCell(listedCategories: filteredCategories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectCategory(indexPath.row)
        dismiss(animated: true, completion:  nil)
    }
    
}
