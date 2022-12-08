//
//  ShopItemSecondView.swift
//  CoffeeHUB
//
//  Created by Abdallah on 02/12/2022.
//

import UIKit
import RxCocoa
import RxSwift


class ShopItemSecondView: UIView {
    
    //MARK: - IBOutlet
    
    let coffeeNameLable = CFCoffeeNameLable()
    let priceLable = CFCoffeeNameSublableLable()
    let countNumber = CFCoffeeNameSublableLable(title: "0", fontSize: 25)
    lazy var addOrder : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "add_button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var removeOrder : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "remove_button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var buttomStackView : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [removeOrder , addOrder])
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    //MARK: - Variables
    
    var viewModel : ShopItemViewModelProtocol!
    var bag = DisposeBag()
    
    // MARK:  init
    
    init(viewModel : ShopItemViewModelProtocol ){
        super.init(frame: .zero)
        self.viewModel = viewModel
        configureUI()
        setConstrains()
        bindUI()
        viewModel.viewDidLoadSecondView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(name : String , price : Float){
        priceLable.text = "£ \(price)"
        coffeeNameLable.text = name
    }
    
    private func configureUI(){
        addSubviews(coffeeNameLable , priceLable , buttomStackView , countNumber)
        translatesAutoresizingMaskIntoConstraints =  false
        coffeeNameLable.text = "CoffeeName"
        priceLable.text = "£ 0.0"
        priceLable.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func setConstrains(){
        
        NSLayoutConstraint.activate([
            coffeeNameLable.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 22),
            coffeeNameLable.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            priceLable.topAnchor.constraint(equalTo: coffeeNameLable.bottomAnchor, constant: 5),
            priceLable.leadingAnchor.constraint(equalTo: coffeeNameLable.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            buttomStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            buttomStackView.widthAnchor.constraint(equalToConstant: 130),
            buttomStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            addOrder.widthAnchor.constraint(equalToConstant: 60),
            removeOrder.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            countNumber.trailingAnchor.constraint(equalTo: buttomStackView.leadingAnchor, constant: -15),
            countNumber.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK:  bindToViewModel
    
    private func bindUI(){
        viewModel.countNumberBehavoir.map({ String($0) }).bind(to: countNumber.rx.text).disposed(by: bag)
        addOrder.rx.tap.bind(to: viewModel.addOrderSubject).disposed(by: bag)
        removeOrder.rx.tap.bind(to: viewModel.removeOrderSubject).disposed(by: bag)
    }
    
}
