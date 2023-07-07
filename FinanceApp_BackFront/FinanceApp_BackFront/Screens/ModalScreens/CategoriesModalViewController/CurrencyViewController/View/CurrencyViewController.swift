//
//  CurrencyScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 10/04/23.
//

import UIKit
import Lottie

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var contentStackView: UIStackView!
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
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    static let identifier:String = String(describing: CurrencyViewController.self)
    var viewModel: CurrencyViewModel = CurrencyViewModel()
    let animationView: LottieAnimationView = .init(name: globalStrings.loadingLottie)
    var sourceValue: Double = 1.0
    var pickerSelected: CurrencyPickerOptions = .nonSelected
    var sourceCoin: CurrencyInfos = coinsList[0]
    var targetCoin: CurrencyInfos = coinsList[4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupStrings()
        setupElements()
        setupPickerView()
        updateExchangeRate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func tappedSourceCoinButton(_ sender: UIButton) {
        currencyPickerView.isHidden = false
        pickerSelected = .source
    }
    
    @IBAction func tappedTargetCoinButton(_ sender: UIButton) {
        currencyPickerView.isHidden = false
        pickerSelected = .target
    }
    
    @IBAction func tappedInvertCoins1(_ sender: UIButton) {
        invertCoins()
    }
    
    @IBAction func tappedInvertCoins2(_ sender: UIButton) {
        invertCoins()
    }
    
    @IBAction func tappedInsertSourceValueButton(_ sender: UIButton) {
        sourceValueContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        let storyboard = UIStoryboard(name: InsertNumbersModalViewController.identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: InsertNumbersModalViewController.identifier) {coder ->
            InsertNumbersModalViewController? in
            return InsertNumbersModalViewController(coder: coder, id: 0)
        }
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    private func updateExchangeRate() {
        if viewModel.dailyRequestMade {
            contentStackView.isHidden = false
            updateSourceValue(sourceValue)
        } else {
            contentStackView.isHidden = true
            setupLottie()
            viewModel.updateExchangeRate()
        }
    }
    
    
    func setupLottie() {
            animationView.translatesAutoresizingMaskIntoConstraints = false
            animationView.frame = view.frame
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.animationSpeed = 1.0
            view.addSubview(animationView)
            animationView.play()
            
            NSLayoutConstraint.activate([
                animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
                animationView.heightAnchor.constraint(equalToConstant: 100),
                animationView.widthAnchor.constraint(equalToConstant: 100),
            ])
    }
    
    private func setupStrings() {
        navigationItem.backButtonTitle = globalStrings.backButtonTitle
        sourceCurrencyButton.setTitle(moreOptionsStrings.dolarText, for: .normal)
        convertedCurrencyButton.setTitle(moreOptionsStrings.realText, for: .normal)
        sourceCurrencyLabel.text = moreOptionsStrings.dolarFullText
        convertedCurrencyLabel.text = moreOptionsStrings.realFullText
        realTimeQuoteLabel.text = moreOptionsStrings.LastQuoteText
    }
    
    private func setupElements() {
        sourceValueContainerView.layer.borderWidth = 1
        sourceValueContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        sourceValueContainerView.layer.cornerRadius = 15
        sourceValueContainerView.layer.masksToBounds = true
    }
    
    private func setupPickerView(){
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
        
        view.addSubview(currencyPickerView)
        currencyPickerView.isHidden = true
    }
    
    private func updateSourceValue(_ value: Double) {
        sourceValue = value
        sourceValueLabel.text = sourceCoin.symbol + globalStrings.spaceChar + viewModel.formatNumberCurrency(value: value)
    }
    
    private func updateSourceLabels() {
        sourceCurrencyButton.setTitle(sourceCoin.name, for: .normal)
        sourceCurrencyLabel.text = sourceCoin.code + moreOptionsStrings.dash + sourceCoin.name + moreOptionsStrings.openParenthesis + sourceCoin.location + moreOptionsStrings.closeParenthesis
    }
    
    private func updateTargetLabels() {
        convertedCurrencyButton.setTitle(targetCoin.name, for: .normal)
        convertedCurrencyLabel.text = targetCoin.code + moreOptionsStrings.dash + targetCoin.name + moreOptionsStrings.openParenthesis + targetCoin.location + moreOptionsStrings.closeParenthesis
    }
    
    private func updateQuoteValues() {
        convertedCurrencyValueLabel.text = viewModel.getConvertedValue(sourceCoin: sourceCoin, targetCoin: targetCoin, value: sourceValue)
        valueQuoteLabel.text = viewModel.getLastExchangeQuote(sourceSymbol: sourceCoin.symbol, targetSymbol: targetCoin.symbol)
        dateLabel.text = viewModel.getActualDate()
        
    }
    
    private func invertCoins() {
        let dataSourceCoin: CurrencyInfos = sourceCoin
        sourceCoin = targetCoin
        targetCoin = dataSourceCoin
        updateSourceLabels()
        updateTargetLabels()
        updateQuoteValues()
        updateSourceValue(sourceValue)
    }
}

extension CurrencyViewController: InsertNumbersModalProtocol {
    func didSelectedNumber(_ value: Double, id: Int) {
        updateSourceValue(value)
        updateQuoteValues()
    }
}

extension CurrencyViewController: CurrencyViewModelProtocol {
    func success() {
        contentStackView.isHidden = false
        animationView.isHidden = true
        updateSourceValue(sourceValue)
        updateQuoteValues()
    }
    
    func error(error: ErrorRequest) {
        showSimpleAlert(title: globalStrings.error, message: error.localizedDescription)
    }
}

extension CurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinsList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinsList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerSelected == .source {
            sourceCoin = viewModel.getCoinInfo(index: row)
            updateSourceLabels()
            updateSourceValue(sourceValue)
        } else if pickerSelected == .target{
            targetCoin = viewModel.getCoinInfo(index: row)
            updateTargetLabels()
        }
        currencyPickerView.isHidden = true
        pickerSelected = .nonSelected
        updateQuoteValues()
    }
    
}
