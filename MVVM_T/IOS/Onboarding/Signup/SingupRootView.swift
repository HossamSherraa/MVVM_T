//
//  SignedInRootView.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit
import Combine
class SignupRootView : UIView {
    
    let viewModel : SignupViewModel
    var subscriptions = Set<AnyCancellable>()
    init(viewModel : SignupViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        buildHierarchy()
        confingConstraints()
        linkViewsStates()
        bindTextFieldsToViewModel()
        linkActionsToViewModel()
    }
    var scrollView : UIScrollView  = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Color.backgroundColor
        scrollView.turnOffAutoresizingMask()
        return scrollView
    }()
    
    
   lazy var signupButton : UIButton =  {
       let button = UIButton()
        button.turnOffAutoresizingMask()
        button.backgroundColor = Color.buttonBackground
        button.setTitle("Signup", for: .normal)
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
    
    var nameTextField : UITextField = {
        let textfield = UITextField()
        textfield.turnOffAutoresizingMask()
        textfield.leftView = UIImageView(image: #imageLiteral(resourceName: "tag_icon"))
        textfield.leftViewMode = .always
        textfield.placeholder = "Name"
        textfield.autocorrectionType = .no
        textfield.keyboardType = .emailAddress
        return textfield
    
    }()
    var nickNameTextField : UITextField = {
        let textfield = UITextField()
        textfield.turnOffAutoresizingMask()
        textfield.leftView = UIImageView(image: #imageLiteral(resourceName: "mobile_icon"))
        textfield.leftViewMode = .always
        textfield.placeholder = "Nick Name"
        textfield.autocorrectionType = .no
        textfield.keyboardType = .emailAddress
        return textfield
    
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
    let stack = UIStackView(arrangedSubviews: [self.nameTextField , self.nickNameTextField , self.emailTextField , self.passwordTextField , self.signupButton])
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
            signupButton.centerXAnchor.constraint(equalTo: loadingIndicator.centerXAnchor),
            signupButton.centerYAnchor.constraint(equalTo: loadingIndicator.centerYAnchor)
            
            
        ])
    }
    
    func buildHierarchy(){
        addSubview(scrollView)
        scrollView.addSubview(containerStack)
        containerStack.addSubview(loadingIndicator)
    }
    
    
    func bindTextFieldsToViewModel(){
        nameTextField
            .text
            .publisher
            .assign(to: \.nameText, on: viewModel)
            .store(in: &subscriptions)
        emailTextField
            .text
            .publisher
            .assign(to: \.emailText, on: viewModel)
            .store(in: &subscriptions)
        passwordTextField
            .text
            .publisher
            .assign(to: \.passwordText, on: viewModel)
            .store(in: &subscriptions)
        nickNameTextField
            .text
            .publisher
            .assign(to: \.nicknameText, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func linkActionsToViewModel(){
        signupButton.addTarget(viewModel, action: #selector(viewModel.onPressSignup), for: .touchUpInside)
    }
    
    func linkViewsStates(){
        viewModel
            .$isButtonEnabled
            .assign(to: \.isEnabled, on: signupButton)
            .store(in: &subscriptions)
        
        viewModel
            .$isNameTextFieldDisabled
            .assign(to: \.isEnabled, on: nameTextField)
            .store(in: &subscriptions)
        
        
        viewModel
            .$isNicknameTextFieldDisabled
            .assign(to: \.isEnabled, on: nickNameTextField)
            .store(in: &subscriptions)
        
        
        viewModel
            .$isEmailTextFieldDisabled
            .assign(to: \.isEnabled, on: emailTextField)
            .store(in: &subscriptions)
        
        viewModel
            .$isPasswordTextFieldDisabled
            .assign(to: \.isEnabled, on: passwordTextField)
            .store(in: &subscriptions)
        
        viewModel
            .$isIndicatorAnimation
            .assign(to: \.isHidden, on: loadingIndicator)
            .store(in: &subscriptions)
        
            
    }
     
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
