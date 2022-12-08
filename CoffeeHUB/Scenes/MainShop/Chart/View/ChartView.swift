//
//  ChartView.swift
//  CoffeeHUB
//
//  Created by Abdallah on 06/12/2022.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftUI

class ChartView: UIView {
    
    //MARK: - IBOutlet
    private let tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ChartCell.self, forCellReuseIdentifier: ChartCell.reuseId)
        return table
    }()
    
    private let containerView = UIView()
    private let totalLable = CFTotalLable(title: .total)
    private let totalPriceLable = CFCoffeeNameSublableLable(title: "£ 0.0", fontSize: 20)
    
    //MARK: - Variables
    private var viewModel : ChartViewModelProtocol!
    private let bag = DisposeBag()
    
    // MARK:  Init
    init(viewModel : ChartViewModelProtocol){
        super.init(frame: .zero)
        self.viewModel = viewModel
        viewModel.viewDidLoad()
        configureUI()
        bindToViewModel()
        getTotalPrice()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI(){
        backgroundColor = .systemBackground
        
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -125),
        ])
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        containerView.addSubview(totalLable)
        NSLayoutConstraint.activate([
            totalLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor , constant: 22),
            totalLable.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        containerView.addSubview(totalPriceLable)
        totalPriceLable.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        NSLayoutConstraint.activate([
            totalPriceLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -22),
            totalPriceLable.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    //MARK: - Helper Function
    
    private func getTotalPrice(){
        viewModel.totalPriceBehavior.bind(to: totalPriceLable.rx.text)
    }
    
    private func bindToViewModel(){
        viewModel.orderslistSubject.bind(to: tableView.rx.items(cellIdentifier: ChartCell.reuseId, cellType: ChartCell.self)){ row , model , cell in
            cell.configureCells(order: model)
        }.disposed(by: bag)
    }
    
}
