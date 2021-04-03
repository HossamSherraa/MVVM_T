//
//  RequestingView.swift
//  MVVM_T
//
//  Created by Hossam on 03/04/2021.
//

import UIKit
class RequestingRideView : UIView {
    
    init() {
        super.init(frame: .zero)
            turnOffAutoresizingMask()
        buildViewHeirarchy()
        buildViewConstraints()
        configViewStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let requestingImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.turnOffAutoresizingMask()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "requesting_indicator")
        return imageView
    }()
    
    let loadingIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.startAnimating()
        return indicator
    }()
    
    let requestNewRideButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Requset New Ride", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.layer.cornerRadius = 20
        button.layer.cornerCurve = .continuous
        button.turnOffAutoresizingMask()
        return button
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.turnOffAutoresizingMask()
        label.text = "Finding Driver ... "
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.white
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    
    let stackContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.turnOffAutoresizingMask()
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    func buildViewHeirarchy(){
        stackContainer.addArrangedSubview(requestingImageView)
        stackContainer.addArrangedSubview(titleLabel)
        stackContainer.addArrangedSubview(loadingIndicator)
        stackContainer.addArrangedSubview(requestNewRideButton)
        self.addSubview(stackContainer)
    }
    
    func buildViewConstraints(){
        NSLayoutConstraint.activate([
            requestingImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            requestingImageView.heightAnchor.constraint(equalTo: widthAnchor , multiplier: 0.5),
            
            requestNewRideButton.widthAnchor.constraint(equalToConstant: 170),
            requestNewRideButton.heightAnchor.constraint(equalToConstant: 65),
            
            stackContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configViewStyle(){
        backgroundColor = Color.backgroundColor
    }
    
}
