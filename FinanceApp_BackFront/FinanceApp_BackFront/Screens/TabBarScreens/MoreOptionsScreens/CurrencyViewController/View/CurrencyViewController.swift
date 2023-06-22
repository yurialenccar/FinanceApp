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
    @IBOutlet weak var sourceValueContainerView: UIView!
    @IBOutlet weak var sourceValueLabel: UILabel!
    @IBOutlet weak var convertedCurrencyLabel: UILabel!
    @IBOutlet weak var convertedCurrencyValueLabel: UILabel!
    @IBOutlet weak var realTimeQuoteLabel: UILabel!
    @IBOutlet weak var valueQuoteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier:String = String(describing: CurrencyViewController.self)
    var viewModel: CurrencyViewModel = CurrencyViewModel()
    var sourceValue: Double = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        updateQuoteValues()
    }
    @IBAction func tappedInsertSourceValueButton(_ sender: UIButton) {
        sourceValueContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        let storyboard = UIStoryboard(name: InsertNumbersModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: InsertNumbersModalViewController.identifier) {coder ->
            InsertNumbersModalViewController? in
            return InsertNumbersModalViewController(coder: coder, value: self.sourceValue, id: 0)
        }
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        sourceCurrencyButton.setTitle(moreOptionsStrings.dolarText, for: .normal)
        convertedCurrencyButton.setTitle(moreOptionsStrings.realText, for: .normal)
        sourceCurrencyLabel.text = moreOptionsStrings.dolarFullText
        convertedCurrencyLabel.text = moreOptionsStrings.realFullText
        realTimeQuoteLabel.text = moreOptionsStrings.realTimeQuoteText
    }
    
    private func setupElements() {
        sourceValueContainerView.layer.borderWidth = 1
        sourceValueContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        sourceValueContainerView.layer.cornerRadius = 15
        sourceValueContainerView.layer.masksToBounds = true
    }
    
    private func updateSourceValue(_ value: Double) {
        sourceValue = value
        sourceValueLabel.text = viewModel.sourcetoMoney(value: value)
    }
    
    private func updateQuoteValues() {
        convertedCurrencyValueLabel.text = viewModel.getConvertedValue(valor: sourceValue)
        valueQuoteLabel.text = viewModel.getActualRealTimeQuote()
        dateLabel.text = viewModel.getActualDate()
        
    }
}

extension CurrencyViewController: InsertNumbersModalProtocol {
    func numberSelected(_ value: Double, id: Int) {
        updateSourceValue(value)
        updateQuoteValues()
    }
}
