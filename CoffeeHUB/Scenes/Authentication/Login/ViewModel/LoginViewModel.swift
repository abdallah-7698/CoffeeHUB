//
//  LoginViewModel.swift
//  CoffeeHUB
//
//  Created by Abdallah on 20/11/2022.
// two version (User - Admin)
// Firebase Auth
// FireBase

import Foundation
import RxSwift
import RxCocoa
import Firebase
import ProgressHUD


enum LoginRouter {
    case navigateToHome
}

protocol LoginViewModelProtocol{
    var emailBehavior : BehaviorRelay<String> { get }
    var passwordBehavior : BehaviorRelay<String> { get }
    
    var loginButtonPublisher : PublishSubject<Void> { get }
    var forgetButtonPublisher : PublishSubject<Void> { get }
    
    var alertSubject : PublishSubject<AlertMessage> { get }
    var routerSubject : PublishSubject<LoginRouter> {get}
    
    func viewDidLoad()
}

class LoginViewModel : LoginViewModelProtocol{
    
    
    var emailBehavior : BehaviorRelay<String>           = .init(value: "")
    var passwordBehavior : BehaviorRelay<String>        = .init(value: "")
    
    var loginButtonPublisher : PublishSubject<Void>     = .init()
    var forgetButtonPublisher : PublishSubject<Void>    = .init()
    
    var alertSubject : PublishSubject<AlertMessage>     = .init()
    var routerSubject: PublishSubject<LoginRouter>      = .init()

    
    let bag = DisposeBag()
    
    
    // MARK:  View Did Load
    
    func viewDidLoad(){
        addLoginAction()
    }

    // MARK:  Button Action
    /// how to navigate to another view controller
    
    private func addLoginAction(){
        loginButtonPublisher.subscribe(onNext: { [weak self] _ in
            guard let self = self else {return}
            let lastValueInEmailTF = self.emailBehavior.value
            let lastValueInPasswordTF = self.passwordBehavior.value

            if !PatternValidate.emailPattern.usedPattern.evaluate(with: lastValueInEmailTF) || lastValueInEmailTF.contains(" ") || lastValueInEmailTF == ""{
                self.alertSubject.onNext(.fail("Email is not Valid"))
            }else if !PatternValidate.passwordPattern.usedPattern.evaluate(with: lastValueInPasswordTF) || lastValueInPasswordTF == ""{
                self.alertSubject.onNext(.fail("Password is not Valid"))
            }else{
                self.firebaseLogin(email: lastValueInEmailTF, password: lastValueInPasswordTF)
            }
        }).disposed(by: bag)
    }
    
    private func addForgetAction(){
        ProgressHUD.show("Loading..")
        forgetButtonPublisher.subscribe { [weak self] (_) in
            guard let self = self else {return}
            if self.emailBehavior.value != ""{
                self.firebaseResetPassword(with: self.emailBehavior.value)
            }
        }.disposed(by: bag)
    }
    
    
    // MARK:  Firebase Auth func
    
    private func firebaseLogin(email: String , password : String){
        ProgressHUD.show("Loading..")
        Auth.auth().rx.signIn(withEmail: email, password: password).subscribe {[weak self] authResult in
            ProgressHUD.dismiss()
            guard let self = self else {return}
            if authResult.user.isEmailVerified{
                self.downloadUserLocallyFromFirestore(byID: authResult.user.uid)
                self.routerSubject.onNext(.navigateToHome)
                self.alertSubject.onNext(.success("Login Success"))
            }else{
                self.alertSubject.onNext(.fail("This email is not verified"))
            }
        } onError: {[weak self] error in
            guard let self = self else {return}
            self.alertSubject.onNext(.fail(error.localizedDescription))
        }.disposed(by: bag)
    }
    
    private func firebaseResetPassword(with email : String){
        Auth.auth().rx.sendPasswordReset(withEmail: email).subscribe {[weak self] (_) in
            guard let self = self else {return}
            self.alertSubject.onNext(.success("You have receved a reset a reset password in your email"))
        } onError: {[weak self] error in
            guard let self = self else {return}
            self.alertSubject.onNext(.fail(error.localizedDescription))
        } onCompleted: {
            print("done")
        }.disposed(by: bag)
    }
    
    private func firebaseSendEmailToCurrentUser(){
        Auth.auth().currentUser?.rx.reloadUser().subscribe {[weak self] () in
            guard let self = self else {return}
            self.firebaseResendVerificationEmail()
        } onError: {[weak self] error in
            guard let self = self else {return}
            self.alertSubject.onNext(.fail(error.localizedDescription))
        } onCompleted: {
            print("done")
        }.disposed(by: bag)
    }
    
    private func firebaseResendVerificationEmail(){
        Auth.auth().currentUser?.rx.sendEmailVerification().subscribe {[weak self] () in
            guard let self = self else {return}
            self.alertSubject.onNext(.success("Success : To resend verification Email"))
        } onError: {[weak self] error in
            guard let self = self else {return}
            self.alertSubject.onNext(.fail(error.localizedDescription))
        } onCompleted: {
            print("done")
        }.disposed(by: bag)
    }
   
    // MARK:  Firebase Firestore Download User
    
    private func downloadUserLocallyFromFirestore(byID id : String){
        FirestoreReference(.User).document(id).rx.getDocument().subscribe {[weak self] documentSnapshot in
            guard let self = self else {return}
            do{
                let user = try documentSnapshot.data(as: UserModel.self)
                saveUserLocally(user)
            }catch{
                self.alertSubject.onNext(.fail("Can't convert the data"))
            }
        } onError: {[weak self]  error in
            guard let self = self else {return}
            self.alertSubject.onNext(.fail(error.localizedDescription))
        } onCompleted: {
            print("done")
        }.disposed(by: bag)
    }
    
}
