//
//  RelatoriosVC.swift
//  FinanceApp_BackFront
//
//  Created by Yuri Alencar on 2023-03-13.
//

import UIKit
import Charts

class RelatoriosVC: UIViewController {
    
        @IBOutlet weak var pieChartView: PieChartView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Configura o gráfico
            
                    pieChartView.chartDescription.enabled = false
                    pieChartView.drawEntryLabelsEnabled = false
                    pieChartView.drawHoleEnabled = true
                    pieChartView.holeColor = .clear
                    pieChartView.holeRadiusPercent = 0.5
                    pieChartView.transparentCircleRadiusPercent = 0.55
                    pieChartView.legend.enabled = false

                    // Definição de dados para o gráfico
                    let entries = [
                        PieChartDataEntry(value: 20, label: "A"),
                        PieChartDataEntry(value: 30, label: "B"),
                        PieChartDataEntry(value: 40, label: "C"),
                        PieChartDataEntry(value: 50, label: "D")
                    ]

                    // Definição de conjunto de dados para o gráfico
                    let dataSet = PieChartDataSet(entries: entries)
                    dataSet.colors = ChartColorTemplates.material()

                    // Definição de data do gráfico
                    let data = PieChartData(dataSet: dataSet)
                    pieChartView.data = data
                }

                override func viewWillAppear(_ animated: Bool) {
                    super.viewWillAppear(animated)
                    self.tabBarController?.navigationController?.isNavigationBarHidden = true
                }

               
            }




