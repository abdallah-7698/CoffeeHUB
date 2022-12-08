//
//  ChartVC.swift
//  CoffeeHUB
//
//  Created by Abdallah on 06/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ChartVC: UIViewController {
    
    private var viewModel : ChartViewModelProtocol!
    private var bag = DisposeBag()
    
    // MARK:  loadView
    
    override func loadView() {
        super.loadView()
        let mainView = ChartView(viewModel: viewModel)
        view = mainView
    }
    
    // MARK:  Init
    
    init(viewModel : ChartViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        viewModel.viewDidLoad()
        configureNavigation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.downloadOrdersData()
    }
    
    private func configureNavigation(){
        addBackArrow(onDispose: &bag)
        title = "Chart"
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "Kohinoor Bangla", size: 19)! ,
            NSAttributedString.Key.foregroundColor : Colors.coffee]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
}
