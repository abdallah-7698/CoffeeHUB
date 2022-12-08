//
//  ShopItemViewModel.swift
//  CoffeeHUB
//
//  Created by Abdallah on 01/12/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import ProgressHUD

enum CoupSizes : String{
    case small
    case big
}

enum SugarSpoons : Int{
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
}

protocol ShopItemViewModelProtocol{
    
    // MARK:  second View
    var shopItemBehavior : BehaviorRelay<Coffee?> { get }
    var addOrderSubject : PublishSubject<Void> { get }
    var removeOrderSubject : PublishSubject<Void> { get }
    var countNumberBehavoir : BehaviorRelay<Int> {get}
    func viewDidLoadSecondView()
    
    // MARK:  Third View
    var coupSelectedBehavior : BehaviorRelay<String> {get}
    var sugarSelectedBehavoir : BehaviorRelay<Int> {get}
    
    // MARK:  Container
    var totalPriceBehavior : BehaviorRelay<Double> {get}
    var addToCartSubject : PublishSubject<Void> {get}
    func viewDidLoad()
    
}


class ShopItemViewModel : ShopItemViewModelProtocol{
    
    // MARK:  secondView
    
    var shopItemBehavior : BehaviorRelay<Coffee?> = .init(value: nil)
    var addOrderSubject : PublishSubject<Void> = .init()
    var removeOrderSubject : PublishSubject<Void> = .init()
    var countNumberBehavoir : BehaviorRelay<Int> = .init(value: 1)
    
    // MARK:  thirdView
    var coupSelectedBehavior : BehaviorRelay<String> = .init(value: CoupSizes.small.rawValue )
    var sugarSelectedBehavoir : BehaviorRelay<Int> = .init(value: SugarSpoons.one.rawValue )
    
    // MARK:  Main Container
    
    var totalPriceBehavior: BehaviorRelay<Double> = .init(value: 0.0)
    var addToCartSubject: PublishSubject<Void> = .init()
    
    
    var bag = DisposeBag()
    
    
    init(coffee : Coffee){
        shopItemBehavior.accept(coffee)
    }
    
    func viewDidLoadSecondView(){
        addItemAction()
        removeItem()
    }
    
    func viewDidLoad(){
        calcTotalPrice()
        addToChartAction()
    }
    
    //MARK: - Helper Function
    
    private func addItemAction(){
        addOrderSubject.subscribe {[weak self] _ in
            guard let self = self else {return}
            if self.countNumberBehavoir.value < 15 {
                self.countNumberBehavoir.accept(self.countNumberBehavoir.value + 1)
            }
        }.disposed(by: bag)
    }
    
    private func removeItem(){
        removeOrderSubject.subscribe {[weak self] _ in
            guard let self = self else {return}
            if self.countNumberBehavoir.value > 1 {
                self.countNumberBehavoir.accept(self.countNumberBehavoir.value - 1)
            }
        }.disposed(by: bag)
    }
    
    // MARK:  third Container
    
    private func calcTotalPrice(){
        Observable.combineLatest(countNumberBehavoir, coupSelectedBehavior).subscribe { [weak self] (_, _) in
            guard let self = self else {return}
            let coupSize = self.coupSelectedBehavior.value == "big" ? 1.0 : 0.0
            self.totalPriceBehavior.accept(Double(self.shopItemBehavior.value?.price ?? 0.0) * Double(self.countNumberBehavoir.value) + Double(self.countNumberBehavoir.value) * Double(self.shopItemBehavior.value?.price ?? 0.0) * coupSize * 0.3)
        }.disposed(by: bag)
    }
    
    private func addToChartAction(){
        addToCartSubject.subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}
            let order = Order(id: UUID().uuidString , coffee: self.shopItemBehavior.value!, count: self.countNumberBehavoir.value, size: self.coupSelectedBehavior.value, sugarSpoons: self.sugarSelectedBehavoir.value)
            self.updateUserWith(orderId: order.id)
            self.uploadAndSave(order: order)
            self.resetDataForUI()
        }).disposed(by: bag)
    }
    
    // MARK:  Update and Save Data
    private func uploadAndSave(order : Order){
        do{
            try FirestoreReference(.Order).document(order.id).setData(from: order)
        }catch{
            ProgressHUD.showError(error.localizedDescription)
        }
    }
    
    private func updateUserWith(orderId : String){
        guard let data = UserDefaults.standard.object(forKey: kCURRENTUSER) else {
            return}
        let decoder = JSONDecoder()
        do{
            var currentUser = try decoder.decode(UserModel.self, from: data as! Data )
            currentUser.orders.append(orderId)
            uploadAndSave(user: currentUser)
        }catch{
            ProgressHUD.showError(error.localizedDescription)
        }
    }
    
    private func uploadAndSave(user : UserModel){
        do{
            try FirestoreReference(.User).document(user.id).setData(from: user)
            saveUserLocally(user)
        }catch{
            ProgressHUD.showError(error.localizedDescription)
        }
    }
    
    private func resetDataForUI(){
        countNumberBehavoir.accept(1)
        coupSelectedBehavior.accept(CoupSizes.small.rawValue)
        sugarSelectedBehavoir.accept(SugarSpoons.one.rawValue)
        totalPriceBehavior.accept(Double(shopItemBehavior.value!.price))
    }
    
}
