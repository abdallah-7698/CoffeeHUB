//
//  ShopView.swift
//  CoffeeHUB
//
//  Created by Abdallah on 29/11/2022.
//

import UIKit

protocol ShopViewProtocol : AnyObject{
    func bindDataTo(tableView : UITableView)
    func onSelectCellAction(tableView : UITableView)
}

class ShopView: UIView {
    
    //MARK: - IBOutlet
    
    var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MenuTVCell.self, forCellReuseIdentifier: MenuTVCell.reuseId)
        return table
    }()
    
    //MARK: - Variables
    
    weak var delegate : ShopViewProtocol?
    
    init( delegate : ShopViewProtocol) {
        super.init(frame: .zero)
        self.delegate = delegate
        configureUI()
        addConstrains()
        
        delegate.bindDataTo(tableView: tableView)
        delegate.onSelectCellAction(tableView: tableView)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Helper Function
    
    private func configureUI(){
        backgroundColor = .systemBackground
        addSubviews(tableView)
    }
    
    
    private func addConstrains(){
        tableView.addConstarint(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, height: nil, width: nil)
    }
    
    
}
