//
//  FirebaseAuthUesr.swift
//  CoffeeHUB
//
//  Created by Abdallah on 24/11/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

extension Reactive where Base : User {
    
    public func updateEmail(to email : String)->Observable<Void>{
        Observable.create { observer in
            self.base.updateEmail(to: email) { error in
                guard let error = error else{
                    observer.onNext(())
                    observer.onCompleted()
                    return
                }
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    /// you must chack first if there is Current User First
    public func sendEmailVerification()->Observable<Void>{
        Observable.create { observer in
            base.sendEmailVerification { error in
                guard let error = error else{
                    observer.onNext(())
                    observer.onCompleted()
                    return
                }
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    public func deleteAccount()->Observable<Void>{
        Observable.create { observer in
            base.delete { error in
                guard let error = error else{
                    observer.onNext(())
                    observer.onCompleted()
                    return
                }
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    public func reloadUser()->Observable<Void>{
        Observable.create { observer in
            base.reload { error in
                guard let error = error else{
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
