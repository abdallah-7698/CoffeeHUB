//
//  SignupView.swift
//  CoffeeHUB
//
//  Created by Abdallah on 25/11/2022.
//

import UIKit


protocol SigninViewProtocol : AnyObject{
    func accessUI(nameTF: UITextField,emailTF: UITextField ,passTF: UITextField , registerButton: UIButton , loginButton : UIButton)
}


class SignupView: UIView {
    
    //MARK: - IBOutlet
    
     var welcomeBackLable = CFBasicLable(title: "Create Account", fontSize: 35, color: Colors.mediamCofee)
        
     var containerView = UIView()
    
     var nameLable              = CFRegisterLable()
     var nameTextField          = CFText(placeholder: .name)
     var underLineViewName      = UIView()
    
     var emailLable              = CFRegisterLable()
     var emailTextField          = CFText(placeholder: .email)
     var underLineViewEmail      = UIView()
    
     var passwordLable           = CFRegisterLable()
     var passwordTextField       = CFText(placeholder: .password)
     var underLineViewPassword   = UIView()
    
     var registerButton          = CFMainButton(title: .register)
     var verticalStack           = CFVerticalStackView()
     var createEmailLable        = CFRegisterLable(title: .haveAccount)
     var loginButton             = CFClearButton(contentText: .login)
    
     var bottomImage             = UIImageView()
    
    //MARK: - Variables
    
    weak var delegate : SigninViewProtocol?
    
    init(delegate : SigninViewProtocol) {
        super.init(frame: .zero)
        self.delegate = delegate
        configureUI()
        addConstrains()
        configureDelegateAccess()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:  Configure UI
    
    private func configureUI(){

        TapToEndEditing()
        backgroundColor = .systemBackground
        addSubviews(welcomeBackLable , containerView , registerButton , bottomImage , verticalStack)
        verticalStack.addArrangedSubviews(createEmailLable , loginButton)
        containerView.addSubviews(nameLable , nameTextField , underLineViewName , emailLable , emailTextField , underLineViewEmail , passwordLable , passwordTextField , underLineViewPassword)
        underLineViewEmail.backgroundColor = .systemGray6
        underLineViewPassword.backgroundColor = .systemGray6
        underLineViewName.backgroundColor = .systemGray6
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        bottomImage.contentMode = .scaleAspectFill
        bottomImage.image = UIImage(named: "artwork")
    }
    
    // MARK:  Constrains
    
    private func addConstrains(){
        welcomeBackLable.addConstrain(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 25, paddingLeading: 20, paddingTrainling: 10, height: 25)
        
        containerView.addConstrain(top: welcomeBackLable.bottomAnchor , leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 13, paddingLeading: 30, paddingTrainling: -30, height: 260)
        
        nameLable.addConstrain(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor , height: 22)
        nameTextField.addConstrain(top: nameLable.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 5, paddingLeading: 10, paddingTrainling: -10, height: 50)
        underLineViewName.addConstrain(top:  nameTextField.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, height: 2)
        
        emailLable.addConstrain(top: underLineViewName.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,paddingTop: 13, height: 22)
        emailTextField.addConstrain(top: emailLable.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 5, paddingLeading: 10, paddingTrainling: -10, height: 50)
        underLineViewEmail.addConstrain(top:  emailTextField.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, height: 2)
        
        passwordLable.addConstrain(top: underLineViewEmail.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 13, height: 22)
        passwordTextField.addConstrain(top: passwordLable.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 5, paddingLeading: 10, paddingTrainling: -10, height: 50)
        underLineViewPassword.addConstrain(top:  passwordTextField.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, height: 2)
        
        registerButton.addConstrain(top: underLineViewPassword.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 20, paddingLeading: 30, paddingTrainling: -30, height: 66)
        verticalStack.addConstarint(top: registerButton.bottomAnchor, leading: registerButton.leadingAnchor, trailing: registerButton.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeading: 50, paddingTrainling: -50, height: 30, width: nil)
        
        bottomImage.addConstarint(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, paddingBottom: 10,height: 380, width: nil)
    }
    
    private func configureDelegateAccess(){
        delegate?.accessUI(nameTF: nameTextField, emailTF: emailTextField, passTF: passwordTextField, registerButton: registerButton, loginButton: loginButton)
    }
    
 
}


//MARK: - Extension

extension SignupView : UITextFieldDelegate {

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            
        if textField.placeholder == "Name"{
            nameLable.text = "Name"
            textField.placeholder = ""
            underLineViewName.backgroundColor = Colors.coffee
        }else if textField.placeholder == "Email"{
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
        if nameTextField.text == "" && nameLable.text == "Name" {
            textField.placeholder = nameLable.text
            nameLable.text = ""
            underLineViewName.backgroundColor = .systemGray6
        }else if emailTextField.text == "" && emailLable.text == "Email"{
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
