//
//  StorageObservableTask.swift
//  CoffeeHUB
//
//  Created by Abdallah on 30/11/2022.
//

import Foundation
import RxSwift
import FirebaseStorage


extension Reactive where Base : StorageObservableTask{
    
    
    public func observe(_ status: StorageTaskStatus) -> Observable<StorageTaskSnapshot> {
        return Observable.create { observer in
            let handle = self.base.observe(status) { snapshot in
                observer.onNext(snapshot)
            }
            return Disposables.create {
                self.base.removeObserver(withHandle: handle)
            }
        }
    }
    
    
}
