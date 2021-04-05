//
//  PickupRootView.swift
//  MVVM_T
//
//  Created by Hossam on 04/04/2021.
//

import UIKit
class PickupRootView : UIView {
    
    init() {
        super.init(frame: .zero)
        buildHeirarchy()
        configViewConstraints()
        configViewStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let whereToGoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Where To Go ?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14 ,weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.turnOffAutoresizingMask()
        return button
    }()
    
    private func buildHeirarchy(){
        self.addSubview(whereToGoButton)
    
    }
    
    private func configViewConstraints(){
        NSLayoutConstraint.activate([
            whereToGoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            whereToGoButton.bottomAnchor.constraint(equalTo: centerYAnchor , constant: -140).setPriority(.defaultHigh),
            whereToGoButton.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 20),
            whereToGoButton.widthAnchor.constraint(equalToConstant: 155),
            whereToGoButton.heightAnchor.constraint(equalToConstant: 60),
            
          
        
            
        ])
    }
    
    private func configViewStyle(){
        whereToGoButton.layer.cornerRadius = 10
        whereToGoButton.layer.shadowColor = UIColor.black.cgColor
        whereToGoButton.layer.shadowRadius = 6
        whereToGoButton.layer.shadowOpacity = 0.2
        whereToGoButton.layer.cornerCurve = .continuous
        
    }
    
}
