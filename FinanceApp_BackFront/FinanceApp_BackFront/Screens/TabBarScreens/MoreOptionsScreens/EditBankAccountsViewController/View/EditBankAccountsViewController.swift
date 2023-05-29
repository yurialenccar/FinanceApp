//
//  ConfigBankAccountsScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import UIKit

class EditBankAccountsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var balanceTextField: UITextField!
    @IBOutlet weak var overdrawLabel: UILabel!
    @IBOutlet weak var overdrawTextField: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var bankDescLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var standardAccountLabel: UILabel!
    @IBOutlet weak var standardAccountSwitch: UISwitch!
    @IBOutlet weak var obsLabel: UILabel!
    @IBOutlet weak var obsTextField: UITextField!
    @IBOutlet weak var titleScreenLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    static let identifier:String = String(describing: EditBankAccountsViewController.self)
    var viewModel:EditBankAccountsViewModel
    var selectedBank:Banks = .bancoDoBrasil
    
    init?(coder:NSCoder, indexAccount:Int, configType:ConfigType){
        self.viewModel = EditBankAccountsViewModel(configType: configType,indexAccount: indexAccount)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError(globalStrings.initError)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.isHidden=true
        setupStrings()
        populateFields()
    }
    
    @IBAction func tappedChangeBankButton(_ sender: UIButton) {
        toggleTableViewVisibility()
    }
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        if stringIsEmpty(text: nameTextField.text ?? ""){
            showAlertWithCancelOption(title: globalStrings.attention, message: moreOptionsStrings.descEmptyMessage,completion: {
                self.saveValues()
            })
        } else{
            saveValues()
        }
    }
    
    private  func setupStrings(){
        switch viewModel.configType {
        case .createNew:
            titleScreenLabel.text = moreOptionsStrings.newBankAccountText
            balanceLabel.text = moreOptionsStrings.accountInitialBalanceText
        case .editExisting:
            titleScreenLabel.text = moreOptionsStrings.editBankAccountText
            balanceLabel.text = moreOptionsStrings.accountBalanceUpdateText
        }
        nameLabel.text = moreOptionsStrings.accountNameText
        overdrawLabel.text = moreOptionsStrings.overdrawText
        standardAccountLabel.text = moreOptionsStrings.standardAccountText
        obsLabel.text = moreOptionsStrings.obsText
        saveButton.setTitle(moreOptionsStrings.saveButtonTitle, for: .normal)
    }
    
    private func saveValues(){
        self.viewModel.saveBankAccount(newBalance:balanceTextField.text.orEmpty, newAccount: BankAccount(
            desc: self.nameTextField.text.orEmpty,
            bank: selectedBank,
            overdraft: Double(self.overdrawTextField.text.orEmpty) ?? 0.0,
            standardAccount: self.standardAccountSwitch.isOn,
            obs: self.obsTextField.text.orEmpty
            ))
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BanksCell.nib(), forCellReuseIdentifier: BanksCell.identifier)
    }
    
    
    
    private func populateFields() {
        let account = viewModel.populateFieldsInfos()
        
        nameTextField.text = account.desc
        overdrawTextField.text = String(account.overdraft)
        standardAccountSwitch.isOn = account.standardAccount
        obsTextField.text = account.obs
        selectedBank = account.bank
        updateBankField(selectedBank)
        
        switch viewModel.configType {
        case .createNew:
            balanceTextField.text = moreOptionsStrings.accountBalanceZeroed
        case .editExisting:
            balanceTextField.text = String(account.balance)
        }
        
    }
    
    private func toggleTableViewVisibility(){
        if tableview.isHidden == false {
            tableview.isHidden = true
        } else {
            tableview.isHidden = false
        }
    }
    
    private func updateBankField(_ bank:Banks){
        bankDescLabel.text = viewModel.getBankName(bank)
        bankLabel.text = viewModel.getBankLabelText(bank)
        bankLabel.font = viewModel.getBankLabelTextFont(bank)
        bankLabel.textColor = viewModel.getBankLabelColor(bank)
        bankBackground.backgroundColor = viewModel.getBankBackColor(bank)
    }
}

extension EditBankAccountsViewController: UITableViewDelegate, UITableViewDataSource{
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

