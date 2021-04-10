//
//  RequestingView.swift
//  MVVM_T
//
//  Created by Hossam on 03/04/2021.
//

import UIKit
import Combine
class RideRequestRootView : UIView {
    private var viewModel : RideRequestViewModel?
    var subscribtions : Set<AnyCancellable> = []
    init() {
        super.init(frame: .zero)
        turnOffAutoresizingMask()
        buildViewHeirarchy()
        buildViewConstraints()
        configViewStyle()
    }
    
    convenience init(viewModel : RideRequestViewModel?){
        self.init()
        self.viewModel = viewModel
        bindingToViewModelState()
        linkViewActionToViewModel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var stateAnimator : StateAnimator? = RequestingRideStateAnimator()
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
        button.layer.opacity = 0
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
    
    func animateToRequestNewRide(){
        stateAnimator?.fade(toHide: false , direction: .top, layer: requestNewRideButton.layer)
        stateAnimator?.fadeAlpha(layer: loadingIndicator.layer)
        stateAnimator?.fadeAlpha(layer: titleLabel.layer)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        viewModel?.onWaitingForPickup()
    }
    func bindingToViewModelState(){
        viewModel?.$state
            .sink(receiveValue: { [weak self] requestState in

                if requestState == .requestNew {
                    self?.animateToRequestNewRide()
                }
            })
            .store(in: &subscribtions)
    }
    
    func linkViewActionToViewModel(){
        self.requestNewRideButton.addTarget(viewModel, action: #selector(viewModel?.onPressRequestNewRide), for: .touchUpInside)
    }
    
}

enum AnimationDirection {
    case top , down
}
protocol StateAnimator {
    func fade( toHide : Bool , direction : AnimationDirection , layer : CALayer)
    func fadeAlpha(layer : CALayer)
}

struct RequestingRideStateAnimator : StateAnimator{
    func fade( toHide : Bool ,direction: AnimationDirection, layer: CALayer) {
        //Alpha Animation
    let yOffset = direction == .down ? 50 : -100
        let alphaAnimator = CABasicAnimation(keyPath: "opacity")
        alphaAnimator.toValue = toHide ? 0 : 1
        alphaAnimator.fromValue = toHide ? 1 : 0
        layer.opacity = toHide ? 0 : 1
        
        //PositionAnimation
        let positionAnimation = CABasicAnimation(keyPath: "transform")
        positionAnimation.valueFunction = CAValueFunction(name: .translateY)
        positionAnimation.fromValue = -150
        positionAnimation.toValue = yOffset
        layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, -100, 0)
        
        //GroupAnimation
        
        let animationGroup = CAAnimationGroup()
        animationGroup.timingFunction = .init(name: .easeInEaseOut)
        animationGroup.duration = 0.4
        animationGroup.animations = [alphaAnimator , positionAnimation]
        
        layer.add(animationGroup, forKey: nil)
        
    }
    
    func fadeAlpha(layer : CALayer) {
        let alphaAnimator = CABasicAnimation(keyPath: "opacity")
        alphaAnimator.toValue = 0
        alphaAnimator.fromValue = 1
        alphaAnimator.timingFunction = .init(name: .easeInEaseOut)
        layer.opacity = 0
        alphaAnimator.duration = 0.4
        layer.add(alphaAnimator, forKey: nil)
    }
    
    
}
