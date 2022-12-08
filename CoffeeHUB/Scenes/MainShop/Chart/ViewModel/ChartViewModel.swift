//
//  ChartViewModel.swift
//  CoffeeHUB
//
//  Created by Abdallah on 06/12/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Firebase
import ProgressHUD

protocol ChartViewModelProtocol{
    func viewDidLoad()
    var orderslistSubject : PublishSubject<[Order]> { get }
    var totalPriceBehavior : BehaviorRelay<String> {get}
    func downloadOrdersData()
}

class ChartViewModel : ChartViewModelProtocol{
    
    var ordersStringId : [String] = []
    var orderslistSubject : PublishSubject<[Order]> = .init()
    var totalPriceBehavior : BehaviorRelay<String> = .init(value: "0.0")
    
    let bag = DisposeBag()
    
    func viewDidLoad(){
        getListOfOrdersId()
        calcTotalOrdersPrice()
    }
    
    private func getListOfOrdersId(){
        guard let data = UserDefaults.standard.object(forKey: kCURRENTUSER) else {
            return}
        let decoder = JSONDecoder()
        do{
            let currentUser = try decoder.decode(UserModel.self, from: data as! Data )
            self.ordersStringId = currentUser.orders
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func downloadOrdersData(){
        ProgressHUD.show("Loading...")
        FirestoreReference(.Order).getDocuments {[weak self] snapshot, error in
            ProgressHUD.dismiss()
            guard let self = self else {return}
            guard let documents = snapshot?.documents  else {
                return}
            guard error == nil else{
                ProgressHUD.showError(error!.localizedDescription)
                return}
            var items = documents.compactMap { snapshop -> Order? in
                return try? snapshop.data(as: Order.self)
            }
            items.sort { $0.createDate! < $1.createDate!}
            self.orderslistSubject.onNext(items)
            ProgressHUD.showSucceed()
        }
    }
    
    private func calcTotalOrdersPrice(){
        orderslistSubject.subscribe(onNext: {[weak self] allOrders in
            guard let self = self else {return}
            var totalPrice : Float = 0.0
            allOrders.forEach { order in
                let addedPrice : Float = order.size == "big" ? 1.0 : 0.0
                totalPrice += order.coffee.price * Float(order.count) + order.coffee.price * Float(order.count) * addedPrice * 0.3
            }
            self.totalPriceBehavior.accept("\(totalPrice)")
        }).disposed(by: bag)
    }
    
    // arrange the orders byDate
    
}
