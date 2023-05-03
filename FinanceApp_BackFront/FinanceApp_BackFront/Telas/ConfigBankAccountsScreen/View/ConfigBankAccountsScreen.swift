//
//  ConfigBankAccountsScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import UIKit

class ConfigBankAccountsScreen: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var balanceTextField: UITextField!
    @IBOutlet weak var overdrawTextField: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var bankDescLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var standardAccountSwitch: UISwitch!
    @IBOutlet weak var obsLabel: UITextField!
    
    var viewModel:ConfigBankAccountViewModel
    var alert=Alert()
    var selectedBank:Banks = .itau
    var account:BankAccount
    var configType:ConfigType
    
    init?(coder:NSCoder, indexAccount:Int, configType:ConfigType){
        self.configType = configType
        self.account = bankAccountsList[indexAccount]
        self.viewModel = ConfigBankAccountViewModel(configType: configType,indexAccount: indexAccount)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.viewController = self
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.isHidden=true
        updateBankField(selectedBank)
        setupScreen()
    }
    
    @IBAction func tappedChangeBankButton(_ sender: UIButton) {
        changeTableviewMode()
    }
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        if stringIsEmpty(text: nameTextField.text ?? ""){
            alert.showAlertWithCancelOption(title: "Atenção", message: "O campo de descrição está vazio, deseja continuar assim mesmo?",completion: {
                self.saveValues()
            })
        } else{
            saveValues()
        }
    }
    
    func saveValues(){
        self.viewModel.setBankAccount(desc: self.nameTextField.text ?? "", bank: self.selectedBank, balance: Double(self.balanceTextField.text ?? "0.0") ?? 0.0, overdraft: Double(self.overdrawTextField.text ?? "0.0") ?? 0.0, stardardBank: self.standardAccountSwitch.isOn, Obs: self.obsLabel.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BanksCell.nib(), forCellReuseIdentifier: BanksCell.identifier)
    }
    
    func setupScreen(){
        if configType == .editExisting{
            nameTextField.text = account.desc
            balanceTextField.text = String(account.balance)
            overdrawTextField.text = String(account.overdraft)
            standardAccountSwitch.isOn = account.stardardBank
            obsLabel.text = account.obs
            updateBankField(account.bank)
        }
    }
    
    func changeTableviewMode(){
        if tableview.isHidden == false {
            tableview.isHidden = true
        } else {
            tableview.isHidden = false
        }
    }
    
    func updateBankField(_ bank:Banks){
        bankDescLabel.text = viewModel.getBankName(bank)
        bankLabel.text = viewModel.getBankLabelText(bank)
        bankLabel.font = viewModel.getBankLabelTextFont(bank)
        bankLabel.textColor = viewModel.getBankLabelColor(bank)
        bankBackground.backgroundColor = viewModel.getBankBackColor(bank)
    }
}

extension ConfigBankAccountsScreen: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getBankListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BanksCell.identifier, for: indexPath) as? BanksCell
        cell?.setupCell(name: viewModel.getBankName(bankList[indexPath.row]))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getRowHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        selectedBank = bankList[indexPath.row]
        updateBankField(selectedBank)
        tableview.isHidden=true
        
    }
}
