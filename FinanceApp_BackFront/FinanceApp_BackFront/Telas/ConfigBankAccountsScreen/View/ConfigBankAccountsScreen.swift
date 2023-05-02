//
//  ConfigBankAccountsScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import UIKit

class ConfigBankAccountsScreen: UIViewController {
    
    var viewModel:ConfigBankAccountViewModel=ConfigBankAccountViewModel()
    var alert=Alert()
    
    var selectedBankIndex:Int=0

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var balanceTextField: UITextField!
    @IBOutlet weak var overdrawTextField: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var bankDescLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var standardAccountSwitch: UISwitch!
    @IBOutlet weak var obsLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.viewController = self
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.isHidden=true
        updateBankField(selectedBankIndex)
    }
    
    @IBAction func tappedChangeBankButton(_ sender: UIButton) {
        changeTableviewMode()
    }
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        if stringIsEmpty(text: nameTextField.text ?? ""){
            alert.showConfirmAlert(title: "Atenção", message: "O campo de descrição está vazio, deseja continuar assim mesmo?",completion: {
                print("Continuar")
                self.viewModel.setNewBankAccount(desc: self.nameTextField.text ?? "", bankIndex: self.selectedBankIndex, balance: Double(self.balanceTextField.text ?? "0.0") ?? 0.0, overdraft: Double(self.overdrawTextField.text ?? "0.0") ?? 0.0, stardardBank: self.standardAccountSwitch.isOn, Obs: self.obsLabel.text ?? "")
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    
    func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BanksCell.nib(), forCellReuseIdentifier: BanksCell.identifier)
    }
    
    func changeTableviewMode(){
        if tableview.isHidden == false {
            tableview.isHidden = true
        } else {
            tableview.isHidden = false
        }
    }
    
    func updateBankField(_ index:Int){
        bankDescLabel.text = viewModel.getBankName(index)
        bankLabel.text = viewModel.getBankLabelText(index)
        bankLabel.font = viewModel.getBankLabelTextFont(index)
        bankLabel.textColor = viewModel.getBankLabelColor(index)
        bankBackground.backgroundColor = viewModel.getBankBackColor(index)
    }
}

extension ConfigBankAccountsScreen: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getBankListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BanksCell.identifier, for: indexPath) as? BanksCell
        cell?.setupCell(name: viewModel.getBankName(indexPath.row))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getRowHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        selectedBankIndex = indexPath.row
        updateBankField(selectedBankIndex)
        tableview.isHidden=true
        
    }
}
