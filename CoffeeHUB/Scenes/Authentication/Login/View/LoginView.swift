//
//  LoginView.swift
//  CoffeeHUB
//
//  Created by Abdallah on 28/11/2022.
//

import UIKit

protocol LoginViewProtocol : AnyObject{
    func accessUI(emailTF : CFText , passwordTF : CFText , loginButton : UIButton , RegisterButton : UIButton , forgetPassword : UIButton)
}

class LoginView: UIView {

    //MARK: - IBOutlet
    
    let welcomeBackLable = CFBasicLable(title: "Welcome Back", fontSize: 35, color: Colors.mediamCofee)
    
    let containerView = UIView()
    
    let emailLable              = CFRegisterLable()
    let emailTextField          = CFText(placeholder: .email)
    let underLineViewEmail      = UIView()
    
    let passwordLable           = CFRegisterLable()
    let passwordTextField       = CFText(placeholder: .password)
    let underLineViewPassword   = UIView()
    
    let forgetPasswordButton    = CFClearButton(contentText: .forgetPass)
    let loginButton             = CFMainButton(title: .login)
    let verticalStack           = CFVerticalStackView()
    let haveEmailLable          = CFRegisterLable(title: .createAccount)
    let registerButton          = CFClearButton(contentText: .register)
    
    let bottomImage             = UIImageView()
    
    //MARK: - Variables
    weak var delegate : LoginViewProtocol?
    
    init(delegate : LoginViewProtocol ){
        super.init(frame: .zero)
        self.delegate = delegate
        configureUI()
        addConstrains()
        configureDelegateAccess()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:  ConFigrue UI
    
    private func configureUI(){
        TapToEndEditing()
        backgroundColor = .systemBackground
        addSubviews(welcomeBackLable , containerView , forgetPasswordButton , loginButton , bottomImage , verticalStack)
        verticalStack.addArrangedSubviews(haveEmailLable , registerButton)
        containerView.addSubviews(emailLable , emailTextField , underLineViewEmail , passwordLable , passwordTextField , underLineViewPassword)
        underLineViewEmail.backgroundColor = .systemGray6
        underLineViewPassword.backgroundColor = .systemGray6
        emailTextField.delegate = self
        passwordTextField.delegate = self
        bottomImage.contentMode = .scaleAspectFill
        bottomImage.image = UIImage(named: "artwork")
    }
    
    // MARK:  Constrains
    
    private func addConstrains(){
        welcomeBackLable.addConstrain(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 30, paddingLeading: 20, paddingTrainling: 10, height: 25)
        containerView.addConstrain(top: welcomeBackLable.bottomAnchor , leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 30, paddingLeading: 30, paddingTrainling: -30, height: 180)
        
        emailLable.addConstrain(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, height: 22)
        emailTextField.addConstrain(top: emailLable.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 5, paddingLeading: 10, paddingTrainling: -10, height: 50)
        underLineViewEmail.addConstrain(top:  emailTextField.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, height: 2)
        
        passwordLable.addConstrain(top: underLineViewEmail.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 13, height: 22)
        passwordTextField.addConstrain(top: passwordLable.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 5, paddingLeading: 10, paddingTrainling: -10, height: 50)
        underLineViewPassword.addConstrain(top:  passwordTextField.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, height: 2)
        
        forgetPasswordButton.addConstarint(top: containerView.bottomAnchor,leading:nil , trailing: containerView.trailingAnchor,bottom:nil , paddingTop: 10, height: 25, width: nil)
        loginButton.addConstrain(top: forgetPasswordButton.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 35, paddingLeading: 30, paddingTrainling: -30, height: 66)
        verticalStack.addConstarint(top: loginButton.bottomAnchor, leading: loginButton.leadingAnchor, trailing: loginButton.trailingAnchor, bottom: nil, paddingTop: 15, paddingLeading: 50, paddingTrainling: -50, height: 30, width: nil)
        
        bottomImage.addConstarint(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, paddingBottom: 10,height: 380, width: nil)
    }
    
     func configureDelegateAccess(){
        delegate?.accessUI(emailTF: emailTextField, passwordTF: passwordTextField, loginButton: loginButton, RegisterButton: registerButton , forgetPassword: forgetPasswordButton )
    }

}

//MARK: - Extension

extension LoginView : UITextFieldDelegate {

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            
        if textField.placeholder == "Email"{
            emailLable.text = "Email"
            textField.placeholder = ""
            underLineViewEmail.backgroundColor = Colors.coffee
        }else if textField.placeholder == "Password"{
            passwordLable.text = "Password"
            textField.placeholder = ""
            underLineViewPassword.backgroundColor = Colors.coffee
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.text == "" && emailLable.text == "Email"{
            textField.placeholder = emailLable.text
            emailLable.text = ""
            underLineViewEmail.backgroundColor = .systemGray6
        }else if passwordTextField.text == "" && passwordLable.text == "Password" {
            textField.placeholder = passwordLable.text
            passwordLable.text = ""
            underLineViewPassword.backgroundColor = .systemGray6
        }
    }
    
}
