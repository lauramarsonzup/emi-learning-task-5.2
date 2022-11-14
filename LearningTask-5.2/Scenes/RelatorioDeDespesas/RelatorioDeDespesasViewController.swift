//
//  RelatorioDeDespesasViewController.swift
//  LearningTask-5.2
//
//  Created by Laura Pinheiro Marson on 26/10/22.
//

import UIKit

class RelatorioDeDespesasViewController: UIViewController {
    
    typealias MensagemDeErro = String
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var tipoTextField: UITextField!
    @IBOutlet weak var valorTextField: UITextField!
    
    @IBOutlet weak var listaDeDespesasView: ListaDeDespesasView!
    @IBOutlet weak var valorTotalLabel: UILabel!
    
    @IBOutlet weak var registrarButton: UIButton!
    
    var viewModel: RelatorioDeDespesasViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
    }
    
    func exibeAlerta(para mensagemDeErro: MensagemDeErro?) {
        let alert = UIAlertController(
            title: "Erro",
            message: mensagemDeErro ?? "Verifique os dados informados e tente novamente.",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    func formularioEhValido() -> (Bool, MensagemDeErro?) {
        return viewModel.verificarTipoDeDespesaValido(titulo: tituloTextField.text, tipo: tipoTextField.text, valor: valorTextField.text)
    }

    @IBAction func botaoAdicionarDespesaPressionado(_ sender: UIButton) {
        switch formularioEhValido() {
            
        case (false, let mensagem):
            exibeAlerta(para: mensagem)
            
        default:
            adicionaDespesa()
        }
    }
    
    func adicionaDespesa() {
        let codigo = Int(tipoTextField.text!)!
        let valor = Converter.paraDecimal(string: valorTextField.text!)!
        
        viewModel.adicionaDespesa(titulo: tituloTextField.text!, codigo: codigo, valor: valor)
    }
    
    func atualizaViews(para relatorio: RelatorioDeDespesas) {
        listaDeDespesasView.atualiza(relatorio.despesas)
        
        valorTotalLabel.text = Formatter.paraMoeda(decimal: relatorio.valorTotal)
        registrarButton.isEnabled = relatorio.valorTotal > 0
    }
    
    @IBAction func botaoRegistrarDespesaPressionado(_ sender: UIButton) {
        
    }
    
}

extension RelatorioDeDespesasViewController: RelatorioDeDespesasViewModelDelegate {
    func relatorioDeDespesasViewModelDelegate(_ viewModel: RelatorioDeDespesasViewModel, didLoadRelatorio relatorioDeDespesas: RelatorioDeDespesas) {
        atualizaViews(para: relatorioDeDespesas)
    }
    
}
