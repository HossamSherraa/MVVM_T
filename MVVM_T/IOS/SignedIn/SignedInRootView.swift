//
//  SignedInRootView.swift
//  MVVM_T
//
//  Created by Hossam on 06/04/2021.
//

import UIKit
class SignedInRootView : UIView {
    var viewModel : SignedInViewModel?
    init() {
        super.init(frame: .zero)
        buildViewHeirarchy()
        
        
    }
    
   convenience init(viewModel : SignedInViewModel) {
        self.init()
        self.viewModel = viewModel
        linkActionsToViewModel()
    }
    
    func linkActionsToViewModel(){
        profileButton.addTarget(viewModel, action: #selector(viewModel?.onPressProfile), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "person_icon"), for: .normal)
        button.turnOffAutoresizingMask()
        button.tintColor = .white
        return button
    }()
    
    func buildViewHeirarchy() {
        self.addSubview(profileButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileButton.frame = bounds
    }
   
}
