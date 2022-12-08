//
//  FireStorageReference.swift
//  CoffeeHUB
//
//  Created by Abdallah on 30/11/2022.
//

import Foundation
import RxSwift
import Firebase
import FirebaseStorage


extension Reactive where Base : StorageReference{
    
    public func putData(_ uploadData: Data, metadata: StorageMetadata? = nil) -> Observable<StorageMetadata> {
        return Observable.create { observer in
            let task = self.base.putData(uploadData, metadata: metadata) { metadata, error in
                guard let error = error else {
                    if let metadata = metadata {
                        observer.onNext(metadata)
                    }
                    observer.onCompleted()
                    return
                }
                observer.onError(error)
            }
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    
    public func downloadURL() -> Observable<URL> {
        return Observable.create { observer in
            self.base.downloadURL { url, error in
                guard let error = error else {
                    if let url = url {
                        observer.onNext(url)
                    }
                    observer.onCompleted()
                    return
                }
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
}
