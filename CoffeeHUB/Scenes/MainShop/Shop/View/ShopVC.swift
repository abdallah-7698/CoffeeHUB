//
//  ShopVC.swift
//  CoffeeHUB
//
//  Created by Abdallah on 23/11/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase

class ShopVC: UIViewController {
    
    //MARK: - IBOutlet
    
    private let chartBarButton : CFChartButton = {
        let button = CFChartButton()
        //0
        button.frame = CGRect(x: -10, y: 0, width: 44, height: 44)
        button.setImage(UIImage(named: "Chart Image Icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        button.tintColor = Colors.mediamCofee
        button.badge = "0"
        return button
    }()
    
    //MARK: - Variables
    let bag = DisposeBag()
    let viewModel : ShopViewModelProtocol = ShopViewModel()
    
    override func loadView() {
        super.loadView()
        let mainView = ShopView(delegate: self)
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// we but it here so the data coms and updates every time the user come to this bage
        guard let data = UserDefaults.standard.object(forKey: kCURRENTUSER) else {
            return}
        let decoder = JSONDecoder()
        do{
            let currentUser = try decoder.decode(UserModel.self, from: data as! Data )
            chartBarButton.badge = "\(currentUser.orders.count)"
        }catch{
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configureNavigation()
        chartButtonAction()
    }
    
    private func configureNavigation(){
        navigationItem.hidesBackButton = true
        title = "Menu"
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "Kohinoor Bangla", size: 19)! ,
            NSAttributedString.Key.foregroundColor : Colors.coffee]
        navigationController?.navigationBar.titleTextAttributes = attributes
        chartBarButton.tintColor = Colors.mediamCofee
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: chartBarButton)
    }
    
    private func chartButtonAction(){
        chartBarButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            let viewModel = ChartViewModel()
            let vc = ChartVC(viewModel: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: bag)
    }
    
    
}

extension ShopVC : ShopViewProtocol{
    
    func bindDataTo(tableView: UITableView) {
        viewModel.shopItemsBehavior.bind(to: tableView.rx.items(cellIdentifier: MenuTVCell.reuseId, cellType: MenuTVCell.self)){ (row , model , cell) in
            cell.configure(coffee: model)
        }.disposed(by: bag)
    }
    
    func onSelectCellAction(tableView: UITableView) {
        tableView.rx.modelSelected(Coffee.self).bind {[weak self] model in
            guard let self = self else {return}
            let coffeeItemViewModle = ShopItemViewModel(coffee: model)
            let vc = ShopItemVC(viewModel: coffeeItemViewModle)
            self.navigationController?.pushViewController(vc, animated: true)
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedRowIndexPath, animated: true)
            }
        }.disposed(by: bag)
    }
    
    
    
}
