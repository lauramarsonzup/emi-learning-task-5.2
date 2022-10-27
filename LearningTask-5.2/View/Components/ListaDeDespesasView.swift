//
//  ListaDeDespesasView.swift
//  LearningTask-5.2
//
//  Created by rafael.rollo on 15/03/2022.
//

import UIKit

class ListaDeDespesasView: UIView {
    
    // MARK: - Subviews
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExpenseItemCell.self, forCellReuseIdentifier: ExpenseItemCell.reuseId)
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 12
        return tableView
    }()

    // MARK: - Propriedades
    private var itens: [Despesa] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Inicializacao
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        addTheme()
        addViews()
        addConstraints()
    }

    private func addTheme() {
        layer.masksToBounds = false
        layer.cornerRadius = 12
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.secondaryLabel.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }

    private func addViews() {
        addSubview(tableView)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    // MARK: API pública
    func atualiza(_ despesas: Despesas) {
        itens = despesas.itens
    }

}

// MARK: - Gestão da tabela
extension ListaDeDespesasView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseItemCell.reuseId, for: indexPath) as? ExpenseItemCell else {
            fatalError("Não foi possível carregar a celula")
        }

        cell.despesa = itens[indexPath.row]
        return cell
    }
}

// MARK: - Implementação da célula
fileprivate class ExpenseItemCell: UITableViewCell {
    static var reuseId: String {
        return String(describing: self)
    }

    // MARK: subviews
    private lazy var tituloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private lazy var descricaoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .italicSystemFont(ofSize: 12)
        return label
    }()

    private lazy var titulosView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            tituloLabel,
            descricaoLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 4
        return stack
    }()

    private lazy var valorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Downriver") ?? .label
        label.font = .boldSystemFont(ofSize: 14)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private lazy var containerView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            titulosView, valorLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 24
        return stack
    }()

    // MARK: Inicialização
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup() {
        addViews()
        addConstraints()
    }

    private func addViews() {
        addSubview(containerView)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
        ])
    }

    // MARK: API
    var despesa: Despesa? {
        didSet {
            guard let despesa = despesa else { return }

            tituloLabel.text = despesa.titulo
            descricaoLabel.text = despesa.tipo.text
            valorLabel.text = Formatter.paraMoeda(decimal: despesa.valor)
        }
    }

}
