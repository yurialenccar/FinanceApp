//
//  CategoriesModalScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 14/04/23.
//

import UIKit

protocol CategoriesModalDelegate: AnyObject {
    func didSelectCategory(_ indexCategory: Int)
}


class CategoriesModalViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static let identifier:String = String(describing: CategoriesModalViewController.self)
    var viewModel:CategoriesModalViewModel
    weak var delegate: CategoriesModalDelegate?
    
    let transactionType:TransactionType
    
    init?(coder:NSCoder, transactionType:TransactionType){
        self.transactionType = transactionType
        viewModel = CategoriesModalViewModel(transactionType: transactionType)
        super.init(coder: coder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

extension CategoriesModalViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCategoriesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesModalCell", for: indexPath) as! CategoriesModalCell
        cell.setupCell(listedCategories: viewModel.getItemCategory(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightSize()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectCategory(indexPath.row)
        dismiss(animated: true, completion:  nil)
    }
    
}
