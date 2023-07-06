//
//  ConfigBankAccountsScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 27/04/23.
//

import UIKit

protocol EditBankAccountsViewControllerProtocol: AnyObject {
    func didSaveAccount(account: BankAccount, indexAccount:Int, configType:ConfigType, newBalance: Double)
}

class EditBankAccountsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var balanceTextField: UITextField!
    @IBOutlet weak var overdraftLabel: UILabel!
    @IBOutlet weak var overdraftTextField: UITextField!
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
    var viewModel: EditBankAccountsViewModel
    weak var delegate: EditBankAccountsViewControllerProtocol?
    var selectedBank: Banks = .bancoDoBrasil
    var balanceValue: Double = 0.0
    var overdraftValue: Double = 0.0
    var initialAccount: BankAccount
    var indexAccount: Int
    
    init?(coder:NSCoder, account: BankAccount, indexAccount:Int, configType:ConfigType){
        self.viewModel = EditBankAccountsViewModel(account: account, configType: configType)
        self.initialAccount = account
        self.indexAccount = indexAccount
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError(globalStrings.initError)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupTableView()
        setupTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.isHidden=true
        populateFields()
    }
    
    @IBAction func tappedInsertBalanceValueButton(_ sender: UIButton) {
        balanceTextField.layer.borderColor = UIColor.systemGray6.cgColor
        let storyboard = UIStoryboard(name: InsertNumbersModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: InsertNumbersModalViewController.identifier) {coder ->
            InsertNumbersModalViewController? in
            return InsertNumbersModalViewController(coder: coder, id: 0)
        }
        vc.delegate = self
        self.present(vc, animated: true)
    }
    @IBAction func tappedInsertOverdrawValueButton(_ sender: UIButton) {
        overdraftTextField.layer.borderColor = UIColor.systemGray6.cgColor
        let storyboard = UIStoryboard(name: InsertNumbersModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: InsertNumbersModalViewController.identifier) {coder ->
            InsertNumbersModalViewController? in
            return InsertNumbersModalViewController(coder: coder, id: 1)
        }
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func tappedChangeBankButton(_ sender: UIButton) {
        toggleTableViewVisibility()
    }
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        if nameTextField.text.orEmpty.isEmptyTest() {
            showAlertWithCancelOption(title: globalStrings.attention, message: moreOptionsStrings.descEmptyMessage,completion: {
                self.saveValues()
            })
        } else {
            self.saveValues()
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
        overdraftLabel.text = moreOptionsStrings.overdrawText
        standardAccountLabel.text = moreOptionsStrings.standardAccountText
        obsLabel.text = moreOptionsStrings.obsText
        saveButton.setTitle(moreOptionsStrings.saveButtonTitle, for: .normal)
    }
    
    private func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BanksCell.nib(), forCellReuseIdentifier: BanksCell.identifier)
    }
    
    private func setupTextFields() {
        nameTextField.delegate = self
        obsTextField.delegate = self
        
        nameTextField.returnKeyType = .done
        obsTextField.returnKeyType = .done
    }
    
    private func saveValues() {
        let account: BankAccount = self.viewModel.saveBankAccount(newAccount: BankAccount(
            desc: self.nameTextField.text.orEmpty,
            bank: selectedBank,
            overdraft: overdraftValue,
            standardAccount: self.standardAccountSwitch.isOn,
            obs: self.obsTextField.text.orEmpty
            ))
        delegate?.didSaveAccount(account: account, indexAccount: indexAccount, configType: viewModel.configType, newBalance: balanceValue)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateBalanceValue(_ value: Double) {
        balanceValue = value
        balanceTextField.text = value.toStringMoney()
    }
    
    private func updateOverdrawValue(_ value: Double) {
        overdraftValue = value
        overdraftTextField.text = value.toStringMoney()
    }
    
    private func populateFields() {
        balanceValue = initialAccount.balance
        overdraftValue = initialAccount.overdraft
        
        nameTextField.text = initialAccount.desc
        overdraftTextField.text = overdraftValue.toStringMoney()
        standardAccountSwitch.isOn = initialAccount.standardAccount
        obsTextField.text = initialAccount.obs
        selectedBank = initialAccount.bank
        updateBankField(selectedBank)
        
        switch viewModel.configType {
        case .createNew:
            balanceTextField.text = moreOptionsStrings.accountBalanceZeroed
        case .editExisting:
            balanceTextField.text = balanceValue.toStringMoney()
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

extension EditBankAccountsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

extension EditBankAccountsViewController: InsertNumbersModalProtocol {
    func numberSelected(_ value: Double, id: Int) {
        if id == 0 {
            updateBalanceValue(value)
        } else if id == 1 {
            updateOverdrawValue(value)
        }
    }
}

