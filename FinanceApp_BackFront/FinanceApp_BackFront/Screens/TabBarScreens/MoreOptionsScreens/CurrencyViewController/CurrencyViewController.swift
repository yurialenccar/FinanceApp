//
//  CurrencyScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/04/23.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var sourceCurrencyButton: UIButton!
    @IBOutlet weak var convertedCurrencyButton: UIButton!
    @IBOutlet weak var sourceCurrencyLabel: UILabel!
    @IBOutlet weak var sourceValueTextField: UITextField!
    @IBOutlet weak var convertedCurrencyLabel: UILabel!
    @IBOutlet weak var convertedCurrencyValueLabel: UILabel!
    @IBOutlet weak var realTimeQuoteLabel: UILabel!
    @IBOutlet weak var valueQuoteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier:String = String(describing: CurrencyViewController.self)
    var viewModel: CurrencyViewModel = CurrencyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        updateQuoteValues()
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        sourceCurrencyButton.setTitle(moreOptionsStrings.dolarText, for: .normal)
        convertedCurrencyButton.setTitle(moreOptionsStrings.realText, for: .normal)
        sourceCurrencyLabel.text = moreOptionsStrings.dolarFullText
        convertedCurrencyLabel.text = moreOptionsStrings.realFullText
        realTimeQuoteLabel.text = moreOptionsStrings.realTimeQuoteText
    }
    
    private func setupTextField() {
        sourceValueTextField.delegate = self
    }
    
    public func updateQuoteValues() {
        let sourceValue = sourceValueTextField.text?.toDouble() ?? 0.0
        convertedCurrencyValueLabel.text = viewModel.getConvertedValue(valor: sourceValue)
        valueQuoteLabel.text = viewModel.getActualRealTimeQuote()
        dateLabel.text = viewModel.getActualDate()
        
    }
}

extension CurrencyViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateQuoteValues()
    }
    
    
}
