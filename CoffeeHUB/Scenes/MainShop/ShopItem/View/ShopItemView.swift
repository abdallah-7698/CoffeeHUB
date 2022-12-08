//
//  ShopItemView.swift
//  CoffeeHUB
//
//  Created by Abdallah on 01/12/2022.
//

import UIKit
import RxCocoa
import RxSwift

class ShopItemView: UIView {
    
    //MARK: - IBOutlet
    
    let containerView1      = ShopItemFirstView()
    var containerView2      : ShopItemSecondView!
    let underLineView1      = UIView()
    var containerView3      : ShopItemThirdView!
    let underLineView2      = UIView()

    let totalLable          = CFTotalLable(title: .total)
    let totalPriceLable     = CFCoffeeNameSublableLable()
    let addToChartButton    = CFMainButton(title: .addToChart)
    
    //MARK: - Constant
    private let bag = DisposeBag()
    var viewModel : ShopItemViewModelProtocol!
    
    // MARK:  init
    
    init(viewModel : ShopItemViewModelProtocol){
        super.init(frame: .zero)
        self.viewModel = viewModel
        containerView2 = ShopItemSecondView(viewModel: viewModel)
        containerView3 = ShopItemThirdView(viewModel: viewModel)
        configureUI()
        addConstrains()
        set(viewModel.shopItemBehavior.value)
        bindUI()
        viewModel.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Function
    
    private func set(_ model : Coffee?){
        guard let model = model else {return}
        containerView1.set(imageStirngURL: model.iconLink)
        containerView2.set(name: model.name, price: model.price)
    }
    
    // MARK:  Configure UI
    
    private func configureUI(){
        backgroundColor = .systemBackground
        addSubviews(containerView1 , containerView2 , underLineView1 , containerView3 , underLineView2 , totalLable , totalPriceLable , addToChartButton)
        totalPriceLable.text = "£ 0"
        totalPriceLable.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        underLineView1.backgroundColor = Colors.coffee
        underLineView2.backgroundColor = Colors.coffee
        
    }
    
    private func addConstrains(){
        
        NSLayoutConstraint.activate([
            containerView1.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerView1.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView1.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView1.heightAnchor.constraint(equalToConstant: 245)
        ])
        NSLayoutConstraint.activate([
            containerView2.topAnchor.constraint(equalTo: containerView1.bottomAnchor),
            containerView2.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView2.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView2.heightAnchor.constraint(equalToConstant: 125)
        ])
        underLineView1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underLineView1.topAnchor.constraint(equalTo: containerView2.bottomAnchor),
            underLineView1.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLineView1.trailingAnchor.constraint(equalTo: trailingAnchor),
            underLineView1.heightAnchor.constraint(equalToConstant: 2)
        ])
        NSLayoutConstraint.activate([
            containerView3.topAnchor.constraint(equalTo: underLineView1.bottomAnchor),
            containerView3.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView3.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView3.heightAnchor.constraint(equalToConstant: 215)
        ])
        underLineView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underLineView2.topAnchor.constraint(equalTo: containerView3.bottomAnchor),
            underLineView2.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLineView2.trailingAnchor.constraint(equalTo: trailingAnchor),
            underLineView2.heightAnchor.constraint(equalToConstant: 2)
        ])

        NSLayoutConstraint.activate([
            totalLable.topAnchor.constraint(equalTo: underLineView2.bottomAnchor, constant: 25),
            totalLable.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 22)
        ])
        NSLayoutConstraint.activate([
            totalPriceLable.topAnchor.constraint(equalTo: underLineView2.bottomAnchor, constant: 25),
            totalPriceLable.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20)
        ])
        NSLayoutConstraint.activate([
            addToChartButton.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 22),
            addToChartButton.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20),
            addToChartButton.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -40),
            addToChartButton.heightAnchor.constraint(equalToConstant: 66)
        ])
    }
    
    // MARK:  bindUI
    
    private func bindUI(){
        viewModel.totalPriceBehavior.map { "\($0)"}.subscribe(onNext: {[weak self] price in
            guard let self = self else {return}
            self.totalPriceLable.text = price
        }).disposed(by: bag)
        addToChartButton.rx.tap.bind(to: viewModel.addToCartSubject).disposed(by: bag)
    }
    
}
