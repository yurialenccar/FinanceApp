import UIKit
import Charts

class CategoriesGraphScreen: UIViewController {
    
    // MARK: - Properties
    
    private var pieChartView: PieChartView!
    private var chartTitle: UILabel!
    private var chartSubtitle: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePieChartView()
        configureChartTitle()
        configureChartSubtitle()
        configureChartLegend()
        configureChartDescription()
        configureChartConstraints()
        updateChartData(for: "Janeiro")
        
    }
    
    // MARK: - Private Methods
    
    private func configurePieChartView() {
        pieChartView = PieChartView(frame: .zero)
        pieChartView.usePercentValuesEnabled = true
        pieChartView.highlightPerTapEnabled = true
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.legend.enabled = true
        pieChartView.holeColor = UIColor.clear
        pieChartView.legend.textColor = UIColor.white
        pieChartView.legend.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func configureChartTitle() {
        chartTitle = UILabel()
        chartTitle.text = "Gastos por Categoria"
        chartTitle.textAlignment = .center
        chartTitle.textColor = .white
        chartTitle.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        chartTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartTitle)
        
        NSLayoutConstraint.activate([
            chartTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            chartTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            chartTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            chartTitle.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func configureChartSubtitle() {
        chartSubtitle = UILabel()
        chartSubtitle.textAlignment = .center
        chartSubtitle.textColor = .white
        chartSubtitle.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        chartSubtitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartSubtitle)
        
        NSLayoutConstraint.activate([
            chartSubtitle.topAnchor.constraint(equalTo: chartTitle.bottomAnchor, constant: 8),
            chartSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            chartSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            chartSubtitle.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func configureChartLegend() {
        pieChartView.legend.orientation = .horizontal
        pieChartView.legend.horizontalAlignment = .center
        pieChartView.legend.verticalAlignment = .bottom
        pieChartView.usePercentValuesEnabled = true // Habilita a exibição dos valores percentuais

    }
    
    private func configureChartDescription() {
        pieChartView.chartDescription.text = ""
    }
    
    private func configureChartConstraints() {
        view.addSubview(pieChartView)
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pieChartView.topAnchor.constraint(equalTo: chartSubtitle.bottomAnchor, constant: 16),
            pieChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            pieChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            pieChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func updateChartData(for mes: String) {
        let sum:[CategoriesSum]=sumExpensesByCategory() 
        let values: [Double] = sum.map{$0.amount}
        let labels: [String] = sum.map{$0.category}
        
        let dataSet = PieChartDataSet(entries: values.enumerated().map { PieChartDataEntry(value: $1, label: labels[$0]) }, label: "")
        dataSet.colors = [.systemMint, .systemPink, .gray, .systemOrange] // Define as cores das fatias do gráfico
        let data = PieChartData(dataSet: dataSet)
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 14, weight: .medium))
        
        pieChartView.data = data
        
        chartSubtitle.text = "\(mes)"
        
        
        let total = values.reduce(0, +)
        let centerText = NSAttributedString(string: "\(total) R$", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)])
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
        
                                      

