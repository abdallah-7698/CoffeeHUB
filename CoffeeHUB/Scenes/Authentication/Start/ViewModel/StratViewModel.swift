//
//  StratViewModel.swift
//  CoffeeHUB
//
//  Created by Abdallah on 21/11/2022.
//

import UIKit
import RxSwift
import RxCocoa


protocol StartViewModelProtocol : AnyObject{
    var imagesObservable : Observable<[UIImage]> { get }
    var visiableCellRowIndex : BehaviorRelay<Int> { get}
    func executeInTime()
}

class StartViewModel : StartViewModelProtocol{
        

    var imagesObservable = Observable<[UIImage]>.of([UIImage(named: "coffeeTime1")! , UIImage(named: "coffeeTime2")! , UIImage(named: "coffeeTime3")!])
    var visiableCellRowIndex : BehaviorRelay<Int> = .init(value: 0)
    var bag = DisposeBag()
    
    func executeInTime(){
        Observable<Int>.interval(RxTimeInterval.milliseconds(2500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {return}
                let newRow = self.visiableCellRowIndex.value < 2 ? self.visiableCellRowIndex.value + 1 : 0
                self.visiableCellRowIndex.accept(newRow)
            }).disposed(by: bag)
    }
    
    
}
