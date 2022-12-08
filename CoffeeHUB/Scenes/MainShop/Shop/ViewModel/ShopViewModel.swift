//
//  ShopViewModel.swift
//  CoffeeHUB
//
//  Created by Abdallah on 23/11/2022.
//
import RxSwift
import RxCocoa
import Firebase
import FirebaseFirestoreSwift
import UIKit
import ProgressHUD

protocol ShopViewModelProtocol{
    var shopItemsBehavior : BehaviorRelay<[Coffee]> {get}
    func viewDidLoad()
}

class ShopViewModel : ShopViewModelProtocol{
    
    
    //MARK: - Variables
    
    let shopItemsBehavior : BehaviorRelay<[Coffee]> = .init(value: [])
    let alertSubject : PublishSubject<AlertMessage> = .init()
    let bag = DisposeBag()
    let storage = Storage.storage()
    
    
    func viewDidLoad(){
        downloadAllCoffeeItems()
    }
    
    // when back from the chart download this func 
    private func downloadAllCoffeeItems(){
        ProgressHUD.show("Loaging..")
        FirestoreReference(.Coffee).getDocuments {[weak self] snapshot, error in
            ProgressHUD.dismiss()
            guard let self = self else {return}
            guard error == nil else {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            guard let documents = snapshot?.documents else{return}
            let items = documents.compactMap { snapshot -> Coffee? in
                return try? snapshot.data(as: Coffee.self)
            }
            self.shopItemsBehavior.accept(items)
            ProgressHUD.showSucceed()
        }
    }
    
    
    
}


// MARK:  Storage upload func


//
//private func uploadImage(){
//
//        let fileDirectory = "CoffeeImages/Macchiato.png"
//    upload(image: UIImage(named: "macchiato")!, directory: fileDirectory)
//
//}
//
//private func upload(image : UIImage ,directory : String){
//    let storageRef = storage.reference(forURL: kFILEREFERENCE).child(directory)
//    let imageData = image.jpegData(compressionQuality: 0.5)!
//    storageRef.rx.putData(imageData).subscribe {[weak self] storageMetadata in
//        guard let self = self else {return}
//        self.downloadFrom(reference: storageRef)
//    } onError: { error in
//        print(error)
//    } onCompleted: {
//        print("done")
//    }.disposed(by: bag)
//}
//// call it in on complete or in onNext ?
//private func downloadFrom(reference : StorageReference ){
//    reference.rx.downloadURL().subscribe { url in
//        do{
//            let coffee = Coffee(name: "Macchiato", iconLink: "\(url)", price: 4.5)
//            try FirestoreReference(.Coffee).document(coffee.name).setData(from: coffee)
//        }catch{
//            self.alertSubject.onNext(.fail(error.localizedDescription))
//        }
//    } onError: { error in
//        print(error)
//    } onCompleted: {
//        print("done")
//    }.disposed(by: bag)
//}
