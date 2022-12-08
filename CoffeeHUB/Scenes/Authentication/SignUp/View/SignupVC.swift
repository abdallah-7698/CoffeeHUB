//
//  SignupVC.swift
//  CoffeeHUB
//
//  Created by Abdallah on 21/11/2022.
//

import UIKit
import RxCocoa
import RxSwift
import ProgressHUD

class SignupVC: UIViewController {
    
    //MARK: - Variables
    
    let viewModel : SignupViewModelProtocol = SignupViewModel()
    var bag = DisposeBag()
    
    var mainView : SignupView?
    //MARK: -  View Life Cicle
    
    override func loadView() {
        super.loadView()
        mainView =  SignupView(delegate: self)
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        viewModel.viewDidLoad()
        handleAlertMessages()
        navigateToShopVC()
    }
    
    
    // MARK:  Configuration
    
    private func configureNavigation(){
        title = "SignUp"
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "Kohinoor Bangla", size: 19)! ,
            NSAttributedString.Key.foregroundColor : Colors.coffee]
        navigationController?.navigationBar.titleTextAttributes = attributes
        addBackArrow(onDispose: &bag)
    }
    
    
    // MARK:  LoginAction
    
    private func handleAlertMessages(){
        viewModel.alertSubject.subscribe(onNext: { alertState in
            switch alertState{
            case .success(let messageSuccess):
                ProgressHUD.showSucceed(messageSuccess)
            case .fail(let error):
                ProgressHUD.showError(error)
            }
        }).disposed(by: bag)
    }
    
    private func navigateToShopVC(){
        viewModel.navigationSubject.subscribe(onNext: {[weak self] navigation in
            guard let self = self else {return}
            switch navigation{
            case .navigateToShop:
                let vc = ShopVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: bag)
    }
    
}

extension SignupVC : SigninViewProtocol{
    
    func accessUI(nameTF: UITextField, emailTF: UITextField, passTF: UITextField, registerButton: UIButton , loginButton: UIButton) {
        nameTF.rx.text.orEmpty.bind(to: viewModel.nameBehavior).disposed(by: bag)
        emailTF.rx.text.orEmpty.bind(to: viewModel.emailBehavior).disposed(by: bag)
        passTF.rx.text.orEmpty.bind(to: viewModel.passwordBehavior).disposed(by: bag)
        
        registerButton.rx.tap.bind(to: viewModel.registerButtonPublisher).disposed(by: bag)
        
        loginButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
            let vc = LoginVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: bag)
        
    }
    
}
