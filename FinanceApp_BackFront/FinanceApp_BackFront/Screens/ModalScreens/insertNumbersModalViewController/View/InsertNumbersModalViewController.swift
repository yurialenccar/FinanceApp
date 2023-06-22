//
//  insertNumbersModalViewController.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 14/06/23.
//

import UIKit

protocol InsertNumbersModalProtocol: AnyObject {
    func numberSelected(_ value: Double)
}

class InsertNumbersModalViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var numbersDisplayView: UIView!
    @IBOutlet weak var numbersDisplayLabel: UILabel!
    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eigthButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var pointButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subButton: UIButton!
    @IBOutlet weak var multButton: UIButton!
    @IBOutlet weak var divButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    static let identifier:String = String(describing: InsertNumbersModalViewController.self)
    var viewModel: InsertNumbersModalViewModel
    weak var delegate: InsertNumbersModalProtocol?
    var amount: Double
    
    init?(coder: NSCoder, amount: Double) {
        self.amount = amount
        self.viewModel = InsertNumbersModalViewModel(amount: amount)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError(globalStrings.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        updateDiplayNumbers(value: viewModel.setValueToExpression(amount))
    }
    
    @IBAction func tappedEraseButton(_ sender: UIButton) {
        let value: String = viewModel.eraseChar()
        updateDiplayNumbers(value: value)
    }
    
    @IBAction func tappedZeroButton(_ sender: UIButton) {
        let value: String = viewModel.insertNumber("0")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedOneButton(_ sender: UIButton) {
        let value: String = viewModel.insertNumber("1")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedTwoButton(_ sender: UIButton) {
        let value: String = viewModel.insertNumber("2")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedThreeButton(_ sender: UIButton) {
        let value: String = viewModel.insertNumber("3")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedFourButton(_ sender: UIButton) {
        let value: String = viewModel.insertNumber("4")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedFiveButton(_ sender: UIButton) {
        let value: String = viewModel.insertNumber("5")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedSixButton(_ sender: UIButton) {
        let value: String = viewModel.insertNumber("6")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedSevenButton(_ sender: UIButton) {
        let value: String = viewModel.insertNumber("7")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedEightButton(_ sender: UIButton) {
        let value: String = viewModel.insertNumber("8")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedNineButton(_ sender: UIButton) {
        let value: String = viewModel.insertNumber("9")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedPointButton(_ sender: UIButton) {
        let value: String = viewModel.insertPoint()
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedAddButton(_ sender: UIButton) {
        let value: String = viewModel.insertOperator("+")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedSubButton(_ sender: UIButton) {
        let value: String = viewModel.insertOperator("-")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedMultButton(_ sender: UIButton) {
        let value: String = viewModel.insertOperator("x")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedDivButton(_ sender: UIButton) {
        let value: String = viewModel.insertOperator("÷")
        updateDiplayNumbers(value: value)
        
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        let value = viewModel.calculateExpression()
        updateDiplayNumbers(value: String(value))
    }
    
    @IBAction func tappedCancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func tappedDoneButton(_ sender: UIButton) {
        let expression = numbersDisplayLabel.text ?? "0"
        var value: Double
        if viewModel.checkOperations(expression) {
            value = viewModel.calculateExpression()
        } else {
            let numbers = expression.suffix(from: expression.index(expression.startIndex, offsetBy: 3))
            value = Double(numbers) ?? 0.0
        }
        delegate?.numberSelected(value)
        dismiss(animated: true)
    }
    
    private func setupElements() {
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
        numbersDisplayView.layer.cornerRadius = 10
        numbersDisplayView.layer.masksToBounds = true
        
        cancelButton.setTitle(insertNumberStrings.cancelButtonTitle, for: .normal)
        doneButton.setTitle(insertNumberStrings.doneButtonTitle, for: .normal)
    }
    
    private func updateDiplayNumbers(value: String) {
        numbersDisplayLabel.text = "R$ \(value)"
    }
}
