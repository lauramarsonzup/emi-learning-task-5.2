//
//  RelatorioDeDespesas.swift
//  LearningTask-5.2
//
//  Created by rafael.rollo on 15/03/2022.
//

import Foundation

struct RelatorioDeDespesas {
    let dataDeCriacao: Date = Date.now
    private(set) var despesas: Despesas = Despesas()
    private(set) var valorTotal: Decimal = 0
    
    mutating func adiciona(_ despesa: Despesa) {
        despesas.adiciona(despesa)
        valorTotal = despesas.total
    }
}

struct Despesas {
    private(set) var itens: [Despesa] = []

    var total: Decimal {
        return itens.map({ $0.valor }).reduce(0, +)
    }

    mutating func adiciona(_ item: Despesa) {
        itens.append(item)
    }
}

struct Despesa {
    let titulo: String
    let tipo: Tipo
    let valor: Decimal
    
    enum Tipo: Int {
        case eletronicos = 1
        case escritorio = 2
        
        var text: String {
            switch self {
            case .eletronicos:
                return "Eletrônicos"
                    
            case .escritorio:
                return "Escritório"
            }
        }
    }
}
