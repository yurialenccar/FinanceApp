//
//  EditCreditCardsViewController.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 08/05/23.
//

import UIKit

class EditCreditCardsViewController: UIViewController {
    
    @IBOutlet weak var titleScreenLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var limitTextField: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var bankDescLabel: UILabel!
    @IBOutlet weak var bankBackground: UIView!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var closingDayTextLabel: UILabel!
    @IBOutlet weak var closingDayNumberLabel: UILabel!
    @IBOutlet weak var dueDateTextLabel: UILabel!
    @IBOutlet weak var dueDateNumberLabel: UILabel!
    @IBOutlet weak var standardCardTextLabel: UILabel!
    @IBOutlet weak var standardCardSwitch: UISwitch!
    @IBOutlet weak var obsTextLabel: UILabel!
    @IBOutlet weak var obsTextField: UITextField!
    @IBOutlet weak var dayPickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    static let identifier:String = String(describing: EditCreditCardsViewController.self)
    var viewModel: EditCreditCardsViewModel
    var selectedBank:Banks = .bancoDoBrasil
    var dayPickerOption: CreditCardDayPickerOptions = .nonSelected
    var limitValue: Double = 0.0
    
    init?(coder:NSCoder, indexCard:Int, configType:ConfigType){
        self.viewModel = EditCreditCardsViewModel(configType: configType, indexCard: indexCard)
        super.init(coder: coder)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError(globalStrings.initError)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTextFields()
        setupPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.isHidden=true
        setupStrings()
        populateFields()
    }
    
    @IBAction func tappedInsertCardLimit(_ sender: UIButton) {
        limitTextField.layer.borderColor = UIColor.systemGray6.cgColor
        let storyboard = UIStoryboard(name: InsertNumbersModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: InsertNumbersModalViewController.identifier) {coder ->
            InsertNumbersModalViewController? in
            return InsertNumbersModalViewController(coder: coder, id: 0)
        }
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func tappedChangeBankButton(_ sender: UIButton) {
        toggleTableViewVisibility()
    }
    
    @IBAction func tappedChangeClosingDayButton(_ sender: UIButton) {
        dayPickerView.isHidden = false
        dayPickerOption = .closingDay
    }
    
    @IBAction func tappedChangeDueDateButton(_ sender: UIButton) {
        dayPickerView.isHidden = false
        dayPickerOption = .dueDate
    }
    
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        if limitValue <= 0.0 {
            showSimpleAlert(title: globalStrings.attention, message: moreOptionsStrings.cardLimitEmptyMessage)
        } else if nameTextField.text.orEmpty.isEmptyTest() {
            showAlertWithCancelOption(title: globalStrings.attention, message: moreOptionsStrings.descEmptyMessage,completion: {
                self.saveValues()
            })
        } else {
            saveValues()
        }
    }
    
    private  func setupStrings(){
        switch viewModel.configType {
        case .createNew:
            titleScreenLabel.text = moreOptionsStrings.newCreditCardText
        case .editExisting:
            titleScreenLabel.text = moreOptionsStrings.editCreditCardText
        }
        nameLabel.text = moreOptionsStrings.cardNameText
        limitLabel.text = moreOptionsStrings.cardLimitText
        closingDayTextLabel.text = moreOptionsStrings.cardClosingDayText
        dueDateTextLabel.text = moreOptionsStrings.cardDueDateText
        standardCardTextLabel.text = moreOptionsStrings.standardCardText
        obsTextLabel.text = moreOptionsStrings.obsText
        saveButton.setTitle(moreOptionsStrings.saveButtonTitle, for: .normal)
    }
    
    private func setupTextFields() {
        nameTextField.delegate = self
        obsTextField.delegate = self
        
        nameTextField.returnKeyType = .done
        obsTextField.returnKeyType = .done
    }
    
    private func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BanksCell.nib(), forCellReuseIdentifier: BanksCell.identifier)
    }
    
    private func populateFields() {
        let card = viewModel.populateFieldsInfos()
        limitValue = card.limit
        
        nameTextField.text = card.desc
        limitTextField.text = limitValue.toStringMoney()
        closingDayNumberLabel.text = String(card.closingDay)
        dueDateNumberLabel.text = String(card.dueDate)
        standardCardSwitch.isOn = card.standardCard
        obsTextField.text = card.obs
        selectedBank = card.bank
        updateBankField(selectedBank)
    }
    
    private func saveValues(){
        viewModel.saveCreditCard(newCard: CreditCard(
            desc: nameTextField.text.orEmpty,
            limit: limitValue,
            bank: selectedBank,
            closingDay: Int(closingDayNumberLabel.text.orEmpty) ?? 0,
            dueDate: Int(dueDateNumberLabel.text.orEmpty) ?? 0,
            standardCard: standardCardSwitch.isOn,
            obs: obsTextField.text.orEmpty)
        )
        self.navigationController?.popViewController(animated: true)
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
    
    private func setupPickerView(){
        dayPickerView.delegate = self
        dayPickerView.dataSource = self
        
        view.addSubview(dayPickerView)
        dayPickerView.isHidden = true
    }
    
    private func updateLimitValue(_ value: Double) {
        limitValue = value
        limitTextField.text = value.toStringMoney()
    }
    
}

extension EditCreditCardsViewController: UITableViewDelegate, UITableViewDataSource{
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

extension EditCreditCardsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 32
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if dayPickerOption == .closingDay{
            closingDayNumberLabel.text = "\(row)"
        } else if dayPickerOption == .dueDate{
            dueDateNumberLabel.text = "\(row)"
        }
        dayPickerView.isHidden = true
    }
    
}

extension EditCreditCardsViewController: InsertNumbersModalProtocol {
    func numberSelected(_ value: Double, id: Int) {
        updateLimitValue(value)
    }
}

extension EditCreditCardsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
