import UIKit
import Charts

class RelatoriosVC: UIViewController {
    
    var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instancia o PieChartView e atribui à variável pieChartView
        pieChartView = PieChartView(frame: .zero)
        
        // Configura os dados do gráfico inicial (mês de janeiro)
        configuraGrafico(mes: "Janeiro")
    }
    
    // Função para configurar os dados do gráfico
    func configuraGrafico(mes: String) {
        // Configura os dados do gráfico
        let valores: [Double] = [2500, 500, 500, 500]
        let labels = ["Casa", "Carro", "Alimentação", "Educação"]
        
        var entradas: [PieChartDataEntry] = []
        
        for i in 0..<valores.count {
            entradas.append(PieChartDataEntry(value: valores[i], label: labels[i]))
        }
        
        let dataSet = PieChartDataSet(entries: entradas, label: "")
        dataSet.colors = [.systemMint, .systemPink, .gray, .systemOrange] // Define as cores das fatias do gráfico
        
        let dados = PieChartData(dataSet: dataSet)
        pieChartView.data = dados
        
        let chartTitle = UILabel()
        chartTitle.text = "Gastos por Categoria"
        chartTitle.textAlignment = .center
        chartTitle.textColor = .white
        chartTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        chartTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartTitle)
        
        
        // Configura o gráfico
        pieChartView.legend.enabled = true // Habilita a legenda do gráfico
        pieChartView.chartDescription.enabled = false // Desabilita a descrição do gráfico
        pieChartView.drawEntryLabelsEnabled = false // Desabilita os rótulos das fatias do gráfico
        pieChartView.usePercentValuesEnabled = true // Habilita a exibição dos valores percentuais
        pieChartView.highlightPerTapEnabled = false // Desabilita a ação de destaque de fatia ao toque
        pieChartView.legend.orientation = .horizontal
        pieChartView.legend.horizontalAlignment = .center
        pieChartView.legend.verticalAlignment = .bottom
        pieChartView.holeColor = UIColor.clear
        pieChartView.legend.textColor = UIColor.white
        pieChartView.legend.font = UIFont.systemFont(ofSize: 16)
       

        
        // Define as constraints manualmente
        view.addSubview(pieChartView) // Adiciona o pieChartView à hierarquia de visualização da view
        pieChartView.translatesAutoresizingMaskIntoConstraints = false // Define que as constraints serão adicionadas manualmente
        
        NSLayoutConstraint.activate([
            pieChartView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            pieChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            pieChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            pieChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            chartTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            chartTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            chartTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            chartTitle.heightAnchor.constraint(equalToConstant: 32)
        ])

        NSLayoutConstraint.activate([
            pieChartView.topAnchor.constraint(equalTo: chartTitle.bottomAnchor, constant: 16),
            pieChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            pieChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            pieChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    // IBAction para exibir a UIAlertController de seleção de mês
    @IBAction func escolherMes(_ sender: Any) {
        let prompt = UIAlertController(title: "Escolher mês", message: nil, preferredStyle: .actionSheet)
        
        let meses = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
        
        for mes in meses {
            let acao = UIAlertAction(title: mes, style: .default) { _ in
                self.configuraGrafico(mes: mes)
            }
            prompt.addAction(acao)
        }
        
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        prompt.addAction(acaoCancelar)
        
        present(prompt, animated: true, completion: nil)
    }
    
}
