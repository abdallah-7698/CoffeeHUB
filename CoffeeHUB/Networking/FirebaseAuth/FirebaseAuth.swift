//
//  FirebaseAuth.swift
//  CoffeeHUB
//
//  Created by Abdallah on 24/11/2022.
//

import Foundation
import Firebase
import RxSwift

extension Reactive where Base : Auth {
    
    // MARK:  Log in
    
    func createUser(withEmail email : String , password : String)->Observable<AuthDataResult>{
        return Observable.create { observer in
            base.createUser(withEmail: email, password: password) { auth, error in
                if let error = error{
                    observer.onError(error)
                }else if let auth = auth {
                    observer.onNext(auth)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK:  Sign in
    
    func signIn(withEmail email : String , password : String)->Observable<AuthDataResult>{
        return Observable.create { observer in
            base.signIn(withEmail: email, password: password) { auth, error in
                if let error = error{
                    observer.onError(error)
                }else if let auth = auth{
                    observer.onNext(auth)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK:  Reset Password
    
    func sendPasswordReset(withEmail email : String)->Observable<Void>{
        return Observable.create { observer in
            base.sendPasswordReset(withEmail: email) { error in
                if let error = error{
                    observer.onError(error)
                }else{
                    observer.onNext(())
                    observer.onCompleted()
                    return
                }
            }
            return Disposables.create()
        }
    }
    
}
