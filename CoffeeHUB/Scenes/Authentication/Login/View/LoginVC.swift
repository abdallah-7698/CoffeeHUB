//
//  LoginVC.swift
//  CoffeeHUB
//
//  Created by Abdallah on 20/11/2022.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class LoginVC: UIViewController {
    
    
    //MARK: - Variables
    
    let viewModel : LoginViewModelProtocol = LoginViewModel()
    var bag = DisposeBag()
    
    
    //MARK: -  View Life Cicle
    
    override func loadView() {
        super.loadView()
        let mainView = LoginView(delegate: self)
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        handelAlertMessage()
        handelNavigation()
        viewModel.viewDidLoad()

    }
    
    // MARK:  Configuration
    
    private func configureNavigation(){
        title = "Login"
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "Kohinoor Bangla", size: 19)! ,
            NSAttributedString.Key.foregroundColor : Colors.coffee]
        navigationController?.navigationBar.titleTextAttributes = attributes
        addBackArrow(onDispose: &bag)
    }
    
    private func handelAlertMessage(){
        viewModel.alertSubject.subscribe(onNext: { message in
            switch message{
            case .success(let sucessMessage):
                ProgressHUD.showSucceed(sucessMessage)
            case .fail(let error):
                ProgressHUD.showError(error)
            }
        }).disposed(by: bag)
    }
    
    private func handelNavigation(){
        viewModel.routerSubject.subscribe(onNext: {[weak self] router in
            guard let self = self else {return}
            switch router{
            case .navigateToHome:
                let vc = ShopVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: bag)
    }
    
}


extension LoginVC : LoginViewProtocol{
    
    func accessUI(emailTF: CFText, passwordTF: CFText, loginButton: UIButton, RegisterButton: UIButton, forgetPassword: UIButton) {
        
        emailTF.rx.text.orEmpty.bind(to: viewModel.emailBehavior).disposed(by: bag)
        passwordTF.rx.text.orEmpty.bind(to: viewModel.passwordBehavior).disposed(by: bag)
        loginButton.rx.tap.bind(to: viewModel.loginButtonPublisher).disposed(by: bag)
        forgetPassword.rx.tap.bind(to: viewModel.forgetButtonPublisher).disposed(by: bag)
        
        RegisterButton.rx.tap.subscribe { [weak self] (_) in
            guard let self = self else {return}
            let vc = SignupVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: bag)
        
    }
    
}
