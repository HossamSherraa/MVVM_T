//
//  SignedInRootView.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit
import Combine
class SignInRootView : UIView {
    let viewModel : SigninViewModel
    var subscribtions = Set<AnyCancellable>()
    init(viewModel : SigninViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.buildHierarchy()
        self.confingConstraints()
        linkActionToViewModel()
        bindTextFieldsToViewModel()
        linkViewsStatesToViewModel()
    }
    var scrollView : UIScrollView  = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Color.backgroundColor
        scrollView.turnOffAutoresizingMask()
        return scrollView
    }()
    
    
   lazy var signInButton : UIButton =  {
       let button = UIButton()
        button.turnOffAutoresizingMask()
        button.backgroundColor = Color.buttonBackground
        button.setTitle("SignIn", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    var loadingIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.turnOffAutoresizingMask()
        indicator.startAnimating()
       
        return indicator
    }()
    
    var emailTextField : UITextField = {
        let textfield = UITextField()
        textfield.turnOffAutoresizingMask()
        textfield.leftView = UIImageView(image: #imageLiteral(resourceName: "email_icon"))
        textfield.leftViewMode = .always
        textfield.placeholder = "Email"
        textfield.autocorrectionType = .no
        textfield.keyboardType = .emailAddress
        return textfield
    
    }()
    
    var passwordTextField : UITextField = {
        let textfield = UITextField()
        textfield.turnOffAutoresizingMask()
        textfield.leftView = UIImageView(image: #imageLiteral(resourceName: "password_icon"))
        textfield.leftViewMode = .always
        textfield.placeholder = "Password"
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    
   lazy var containerStack : UIStackView = {
    let stack = UIStackView(arrangedSubviews: [self.emailTextField , self.passwordTextField , self.signInButton])
    stack.turnOffAutoresizingMask()
    stack.axis = .vertical
    stack.alignment = .fill
    stack.spacing = 20
    stack.distribution = .fill
    return stack
    }()
    
    
    
    
    
    
    func confingConstraints(){
        NSLayoutConstraint.activate([
        //Scroll
            self.scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            self.scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: widthAnchor),
            self.scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: heightAnchor),
            
            
        //ContainerStack
            containerStack.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor),
            containerStack.centerYAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerYAnchor),
            containerStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 0.8),
            
        //LoadingIndicator
            signInButton.centerXAnchor.constraint(equalTo: loadingIndicator.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: loadingIndicator.centerYAnchor)
            
            
        ])
    }
    
    func buildHierarchy(){
        addSubview(scrollView)
        scrollView.addSubview(containerStack)
        containerStack.addSubview(loadingIndicator)
        
    }
    
    func linkActionToViewModel(){
        signInButton.addTarget(viewModel, action: #selector(viewModel.onSignin), for: .touchUpInside)
    }
    
    
    func bindTextFieldsToViewModel(){
        emailTextField.text
            .publisher
            .assign(to: \.emailText, on: viewModel)
            .store(in: &subscribtions)
        
        passwordTextField.text
            .publisher
            .assign(to: \.passwordText, on: viewModel)
            .store(in: &subscribtions)
    }
    
    func linkViewsStatesToViewModel(){
        viewModel
            .$isEmailTextFieldDisabled
            .assign(to: \.isEnabled, on: emailTextField)
            .store(in: &subscribtions)
        
        viewModel
            .$isPasswordTextFieldDisabled
            .assign(to: \.isEnabled, on: passwordTextField)
            .store(in: &subscribtions)
        
        
        viewModel
            .$isIndicatorAnimation
            .assign(to: \.isHidden, on: loadingIndicator)
            .store(in: &subscribtions)
            
        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
