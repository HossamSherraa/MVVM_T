//
//  SignedInRootView.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit
import Combine
class SignInRootView : UIView , Bindable {
    var subscriptions: Set<AnyCancellable> = .init()
    
    typealias ViewModel = SigninViewModel

    var viewModel : SigninViewModel
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
        button.setTitle("", for: .disabled)
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
        
        
            
            bindTextFieldText(emailTextField, to: \.emailText)
            bindTextFieldText(passwordTextField, to: \.passwordText)
           
        
    }
    
    func linkViewsStatesToViewModel(){
        bindState(to: emailTextField, uiComponents: \.isEnabled, state: \.$isEmailTextFieldDisabled)
        bindState(to: passwordTextField, uiComponents: \.isEnabled, state: \.$isPasswordTextFieldDisabled)
        bindState(to: signInButton, uiComponents: \.isEnabled, state: \.$isButtonEnabled)
        bindState(to: loadingIndicator, uiComponents: \.isHidden, state: \.$isIndicatorAnimation)
            
        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
