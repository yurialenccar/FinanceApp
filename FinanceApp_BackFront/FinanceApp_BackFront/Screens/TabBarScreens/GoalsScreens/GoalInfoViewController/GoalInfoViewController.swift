//
//  GoalInfoScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/04/23.
//

import UIKit

class GoalInfoViewController: UIViewController {
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var goalProgressBar: UIProgressView!
    @IBOutlet weak var savedAmountLabel: UILabel!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daysToDateLabel: UILabel!
    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var saveAmountButton: UIButton!
    
    static let identifier:String = String(describing: GoalInfoViewController.self)

    var goal:Goal
    
    init?(coder:NSCoder, goal:Goal){
        self.goal = goal
        super.init(coder: coder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError(globalStrings.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
        setupScreen(goal: goal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    private func setupStrings() {
        goalLabel.text = goalStrings.goalText
        saveAmountButton.setTitle(goalStrings.saveAmountButtonTitle, for: .normal)
    }
    
    private func setupScreen(goal:Goal){
        descLabel.text = goal.desc
        goalImage.image = UIImage(imageLiteralResourceName: goal.imageName)
        goalProgressBar.progress = Float(goal.savedAmount/goal.goalValue)
        savedAmountLabel.text = goal.savedAmount.toStringMoney()
        targetValueLabel.text = goal.goalValue.toStringMoney()
        dateLabel.text = goalStrings.targetDateToGoalText + goal.targetDate
        daysToDateLabel.text = goalStrings.DaysToTargetDate(goal: goal)
        recommendationLabel.text = goalStrings.recommendingText(goal: goal)
    }
}
