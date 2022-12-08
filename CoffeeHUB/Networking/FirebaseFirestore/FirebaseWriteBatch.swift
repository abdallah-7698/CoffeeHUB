//
//  FirebaseWriteBatch.swift
//  CoffeeHUB
//
//  Created by Abdallah on 05/12/2022.
//

import RxCocoa
import RxSwift
import FirebaseFirestore

extension Reactive where Base: WriteBatch {
    
    public func commit() -> Observable<Void> {
        return Observable.create { observer in
            self.base.commit { error in
                guard let error = error else {
                    observer.onNext(())
                    observer.onCompleted()
                    return
                }
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
