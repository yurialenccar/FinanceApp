//
//  CategoriesGraphCollectionViewCell.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 16/05/23.
//

import UIKit
import Charts

class CategoriesGraphCollectionViewCell: UICollectionViewCell {
    
    static let identifier:String = String(describing: CategoriesGraphCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    private var pieChartView: PieChartView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configurePieChartView()
        configureChartConstraints()
        configureChartLegend()
        updateChartData()
    }
    
    private func configurePieChartView() {
        pieChartView = PieChartView(frame: .zero)
        pieChartView.usePercentValuesEnabled = true
        pieChartView.highlightPerTapEnabled = false
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.holeColor = UIColor.clear
        pieChartView.isUserInteractionEnabled = false
    }
    
    private func configureChartConstraints() {
        contentView.addSubview(pieChartView)
        pieChartView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pieChartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pieChartView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pieChartView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            pieChartView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureChartLegend() {
        pieChartView.legend.enabled = true
        pieChartView.legend.textColor = UIColor.black
        pieChartView.legend.font = UIFont.systemFont(ofSize: 15)
        pieChartView.legend.orientation = .vertical
        pieChartView.legend.horizontalAlignment = .right
        pieChartView.legend.verticalAlignment = .center

    }

    private func updateChartData() {
        let sum: [CategoriesSum] = sumExpensesByCategory()
        let values: [Double] = sum.map{$0.amount}
        let labels: [String] = sum.map{$0.category}
        
        let dataSet = PieChartDataSet(entries: values.enumerated().map { PieChartDataEntry(value: $1, label: labels[$0]) }, label: globalStrings.emptyString)
        dataSet.colors = [.systemMint, .systemPink, .gray, .systemOrange] // Define as cores das fatias do gráfico
        let data = PieChartData(dataSet: dataSet)
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 14, weight: .medium))
        
        pieChartView.data = data
        
        
        
        let total = values.reduce(0, +)
        let centerText = NSAttributedString(string: total.toStringMoney(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)])
        pieChartView.centerAttributedText = centerText

        pieChartView.tintColor = .white

        pieChartView.centerAttributedText = centerText

        pieChartView.tintColor = .white
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))

    }

}
