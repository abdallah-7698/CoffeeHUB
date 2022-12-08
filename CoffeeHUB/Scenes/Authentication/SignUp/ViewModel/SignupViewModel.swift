//
//  SignupViewModel.swift
//  CoffeeHUB
//
//  Created by Abdallah on 21/11/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import ProgressHUD



enum AlertMessage{
    case success(String)
    case fail(String)
}

enum Navigation{
    case navigateToShop
}


protocol SignupViewModelProtocol{
    var nameBehavior : BehaviorRelay<String> { get }
    var emailBehavior : BehaviorRelay<String> { get }
    var passwordBehavior : BehaviorRelay<String> { get }
    var alertSubject : PublishSubject<AlertMessage> {get}
    var navigationSubject : PublishSubject<Navigation> {get}
    
    var registerButtonPublisher : PublishSubject<Void> { get }
    func viewDidLoad()
}

class SignupViewModel : SignupViewModelProtocol {
    
    var registerButtonPublisher: PublishSubject<Void> = .init()
    
    let bag = DisposeBag()
    
    var nameBehavior: BehaviorRelay<String>             = .init(value: "")
    var emailBehavior : BehaviorRelay<String>           = .init(value: "")
    var passwordBehavior : BehaviorRelay<String>        = .init(value: "")
    var alertSubject : PublishSubject<AlertMessage>     = .init()
    var navigationSubject: PublishSubject<Navigation>   = .init()
    // MARK:  View Did Load
    
    func viewDidLoad(){
        addRegisterAction()
    }
    
    
    // MARK: Register Button Action
    
    private func addRegisterAction(){
        registerButtonPublisher.subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}
            let lastValueInNameTF = self.nameBehavior.value
            let lastValueInEmailTF = self.emailBehavior.value
            let lastValueInPasswordTF = self.passwordBehavior.value
            if !PatternValidate.namePattern.usedPattern.evaluate(with: lastValueInNameTF) || lastValueInNameTF == ""{
                self.alertSubject.onNext(.fail("name is not valid"))
            }else if !PatternValidate.emailPattern.usedPattern.evaluate(with: lastValueInEmailTF) || lastValueInEmailTF.contains(" ") || lastValueInEmailTF == ""{
                self.alertSubject.onNext(.fail("email is not valid"))
            }else if !PatternValidate.passwordPattern.usedPattern.evaluate(with: lastValueInPasswordTF) || lastValueInPasswordTF == ""{
                self.alertSubject.onNext(.fail("password is not valid"))
            }else{
                self.firebaseSignup(email : lastValueInEmailTF, password : lastValueInPasswordTF)
            }
        }).disposed(by: bag)
    }
    
    // MARK:  Firebase Signup
    private func firebaseSignup(email : String , password : String){
        ProgressHUD.show()
        Auth.auth().rx.createUser(withEmail: email, password: password).subscribe {[weak self] authResult in
            ProgressHUD.dismiss()
            guard let self = self else {return}
            self.firebaseSendEmailVerification(authResult: authResult)
            let user = UserModel(id: authResult.user.uid, userName: self.nameBehavior.value, email: self.emailBehavior.value, orders: [])
            self.saveUserToFireStore(user: user)
            saveUserLocally(user)
        } onError: {[weak self] error in
            guard let self = self else {return}
            self.alertSubject.onNext(.fail(error.localizedDescription))
        }.disposed(by: bag)
    }
    
    private func firebaseSendEmailVerification(authResult : AuthDataResult){
        authResult.user.rx.sendEmailVerification().subscribe {[weak self] _ in
            guard let self = self else {return}
            self.alertSubject.onNext(.success("Success To Sent verification Email"))
            self.navigationSubject.onNext(.navigateToShop)
        } onError: {[weak self] error in
            guard let self = self else {return}
            self.alertSubject.onNext(.fail(error.localizedDescription))
        }.disposed(by: bag)
    }
    
    // MARK:  Firebase Firestore
    
    private func saveUserToFireStore(user : UserModel){
        do{
            try FirestoreReference(.User).document(user.id).setData(from: user)
        }catch{
            print(error.localizedDescription)
        }
    }
    
}
