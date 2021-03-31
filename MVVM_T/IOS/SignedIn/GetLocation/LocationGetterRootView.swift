//
//  LocationRootView.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import UIKit
class LocationGetterRootView : UIView {
    let viewModel : LocationViewModel
     let kooperLogo : UIImageView = {
        let image = UIImageView()
        image.turnOffAutoresizingMask()
        image.image = #imageLiteral(resourceName: "koober")
        return image
     }()
    let titleLabel : UILabel = {
        let label = UILabel()
        label.turnOffAutoresizingMask()
        label.text = "Finding Your Location ... "
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.white
        return label
    }()
    
    
     init(viewModel : LocationViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        buildViewHeirarchy()
        buildConstraints()
        configStyle()
        startGetLocation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHeirarchy(){
        addSubview(kooperLogo)
        addSubview(titleLabel)
    }
    
    func buildConstraints(){
        NSLayoutConstraint.activate([
            kooperLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            kooperLogo.centerYAnchor.constraint(equalTo: centerYAnchor),
            kooperLogo.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            kooperLogo.heightAnchor.constraint(equalTo: widthAnchor , multiplier: 0.5),
            
            titleLabel.centerXAnchor.constraint(equalTo: kooperLogo.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: kooperLogo.bottomAnchor , constant: 30)
        ])
    }
    
    func configStyle(){
        backgroundColor = Color.backgroundColor
    }
    
    
    func startGetLocation(){
        viewModel.determineUserLocation()
    }
    
    
    
}
