//
//  LaunchRootView.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit
class WelcomeRootView : UIView {
    let viewModel : WelcomeViewModel
    init(viewModel : WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        buildHierarchy()
        confingConstraints()
        configViewStyle()
        linkActionsToViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let signupButton : UIButton = {
        let button = UIButton()
        button.setTitle("Signup", for: .normal)
        button.turnOffAutoresizingMask()
        button.backgroundColor = Color.buttonBackground
        button.layer.cornerRadius = 10
        button.layer.cornerCurve = .continuous
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    let signinButton : UIButton = {
        let button = UIButton()
        button.setTitle("SignIn", for: .normal)
        button.turnOffAutoresizingMask()
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 10
        button.layer.cornerCurve = .continuous
        button.layer.borderWidth = 2
        button.layer.borderColor = Color.buttonBackground.cgColor
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitleColor(Color.buttonBackground, for: .normal)
        return button
    }()
    
    let logoIcon : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "roo_logo"))
        imageView.turnOffAutoresizingMask()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var stackContainer : UIStackView  = {
       let stack = UIStackView(arrangedSubviews: [signupButton , signinButton])
        stack.turnOffAutoresizingMask()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    
   
    func buildHierarchy(){
        addSubview(logoIcon)
        addSubview(stackContainer)
        
        
    }
    
    func confingConstraints(){
        NSLayoutConstraint.activate([
        //Logo
            logoIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoIcon.widthAnchor.constraint(equalToConstant: 200),
            logoIcon.heightAnchor.constraint(equalToConstant: 200),
            
        //Stack
            
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: stackContainer.bottomAnchor, constant: 20),
            stackContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackContainer.widthAnchor.constraint(equalTo: widthAnchor , multiplier: 0.8)
        ])
    }
    
    func configViewStyle(){
        self.backgroundColor = Color.backgroundColor
    }
    
    func linkActionsToViewModel(){
        signupButton.addTarget(viewModel, action: #selector(viewModel.onSignup), for: .touchUpInside)
        signinButton.addTarget(viewModel, action: #selector(viewModel.onSignin), for: .touchUpInside)
    }
}
