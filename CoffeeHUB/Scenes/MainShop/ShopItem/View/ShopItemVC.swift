//
//  ShopItemVC.swift
//  CoffeeHUB
//
//  Created by Abdallah on 01/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ShopItemVC: UIViewController {

    var viewModel : ShopItemViewModelProtocol!
    var bag = DisposeBag()
    
    init(viewModel : ShopItemViewModelProtocol){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let mainView = ShopItemView(viewModel: viewModel)
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        
    }
    
    private func configureNavigation(){
        addBackArrow(onDispose: &bag)
        self.title = viewModel.shopItemBehavior.value?.name
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "Kohinoor Bangla", size: 19)! ,
            NSAttributedString.Key.foregroundColor : Colors.coffee]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }

}
