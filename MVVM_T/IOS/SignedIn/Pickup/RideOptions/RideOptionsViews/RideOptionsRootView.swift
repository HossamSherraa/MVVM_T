//
//  RideOptionsRootView.swift
//  MVVM_T
//
//  Created by Hossam on 03/04/2021.
//

import UIKit
class RideOptionsRootView : UIView {
    
    
    
    init() {
        super.init(frame: .zero)
        buildViewHeirarchy()
        configViewStyle()
        buildViewsConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let confirmButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.layer.cornerRadius = 20
        button.layer.cornerCurve = .continuous
        button.turnOffAutoresizingMask()
        return button
    }()
    
    let stackRideOptionsContainer : UIView = {
        let container = RideOptionContainerView()
        container.turnOffAutoresizingMask()
        return container
    }()
    
    func buildViewHeirarchy(){
        
       addSubview(stackRideOptionsContainer)
       addSubview(confirmButton)
    }
    
    func configViewStyle(){
        backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
    }
    
    func buildViewsConstraints(){
        NSLayoutConstraint.activate([

            heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            stackRideOptionsContainer.topAnchor.constraint(equalTo: topAnchor , constant: 20),
            stackRideOptionsContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackRideOptionsContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            confirmButton.centerYAnchor.constraint(equalTo: bottomAnchor),
            confirmButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: 120),
            confirmButton.heightAnchor.constraint(equalToConstant: 60)
            
            
            
            
           
        ])
        
    }
    
    
}
