//
//  GoalInfoScreen.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 26/04/23.
//

import UIKit

class GoalInfoViewController: UIViewController {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var goalProgressBar: UIProgressView!
    @IBOutlet weak var savedAmountLabel: UILabel!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daysToDateLabel: UILabel!
    @IBOutlet weak var recommendationLabel: UILabel!
    
    static let identifier:String = String(describing: GoalInfoViewController.self)

    var goal:Goal
    
    init?(coder:NSCoder, goal:Goal){
        self.goal = goal
        super.init(coder: coder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen(goal: goal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    
    func setupScreen(goal:Goal){
        descLabel.text = goal.desc
        goalImage.image = UIImage(imageLiteralResourceName: goal.imageName)
        goalProgressBar.progress = Float(goal.savedAmount/goal.goalValue)
        savedAmountLabel.text = "R$ \(goal.savedAmount)0"
        targetValueLabel.text = "R$ \(goal.goalValue)0"
        dateLabel.text = "Data alvo para alcançar a meta: \(goal.targetDate)"
        daysToDateLabel.text = goal.DaysToTargetDate
        recommendationLabel.text = goal.recommendation
    }
}
