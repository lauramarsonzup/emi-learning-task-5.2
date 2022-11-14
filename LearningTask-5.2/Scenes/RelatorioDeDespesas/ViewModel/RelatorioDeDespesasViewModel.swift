//
//  RelatorioDeDespesasViewModel.swift
//  LearningTask-5.2
//
//  Created by Laura Pinheiro Marson on 14/11/22.
//

import Foundation

protocol RelatorioDeDespesasViewModelDelegate: AnyObject {
    func relatorioDeDespesasViewModelDelegate(_ viewModel: RelatorioDeDespesasViewModel, didLoadRelatorio relatorioDeDespesas: RelatorioDeDespesas)
}

struct RelatorioDeDespesasViewModel {
    weak var delegate: RelatorioDeDespesasViewModelDelegate?
    
    var relatorioDeDespesas: RelatorioDeDespesas? {
        didSet {
            guard let relatorioDeDespesas = relatorioDeDespesas else { return }
            delegate?.relatorioDeDespesasViewModelDelegate(self, didLoadRelatorio: relatorioDeDespesas)
        }
    }
    
    init(relatorio: RelatorioDeDespesas) {
        relatorioDeDespesas = relatorio
    }
    
    mutating func adicionaDespesa(titulo: String, codigo: Int, valor: Decimal) {
        let tipo = Despesa.Tipo(rawValue: codigo)!
        
        let despesa = Despesa(titulo: titulo,
                              tipo: tipo,
                              valor: valor)
        relatorioDeDespesas?.adiciona(despesa)
    }
    
    func verificarTipoDeDespesaValido(titulo: String?, tipo: String?, valor: String?) -> (Bool, String?) {
        
        if let titulo = titulo, titulo.isEmpty {
            return (false, "Título inválido")
        }
        
        guard let tipoComoTexto = tipo,
              let tipo = Int(tipoComoTexto),
              let _ = Despesa.Tipo(rawValue: tipo) else {
            return (false, "Tipo de despesa inválido")
        }
        
        guard let valorEmTexto = valor,
              let _ = Converter.paraDecimal(string: valorEmTexto) else {
            return (false, "Valor inválido")
        }
        
        return (true, nil)
        
    }
}
