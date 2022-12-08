//
//  FirebaseDocumentReference.swift
//  CoffeeHUB
//
//  Created by Abdallah on 29/11/2022.
//
import UIKit
import RxCocoa
import FirebaseFirestore
import RxSwift

extension Reactive where Base : DocumentReference {
    
    public func getDocument()->Observable<DocumentSnapshot> {
        return Observable.create { observer in
            self.base.getDocument { snapshot, error in
                if let error = error {
                    observer.onError(error)
                }else if let snapshot = snapshot , snapshot.exists{
                    observer.onNext(snapshot)
                    observer.onCompleted()
                }else{
                    observer.onError(NSError(domain: FirestoreErrorDomain, code: FirestoreErrorCode.notFound.rawValue, userInfo: nil))
                }
            }
            return Disposables.create()
        }
    }

    
    public func delete() -> Observable<Void> {
          return Observable<Void>.create { observer in
              self.base.delete { error in
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
    
    public func updateData(_ fields: [AnyHashable: Any]) -> Observable<Void> {
        return Observable<Void>.create { observer in
            self.base.updateData(fields) { error in
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
