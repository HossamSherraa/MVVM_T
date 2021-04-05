//
//  RideOptionsStack.swift
//  MVVM_T
//
//  Created by Hossam on 03/04/2021.
//

import UIKit
import Combine
struct TestOptionOptionModel {
    let name : String = "Option1"
    let selectedImage = "available_wallabe_marker"
    let unselectedImage = "available_kangaroo_marker"
}
class RideOptionContainerView : UIView {
    var subscribtions : Set<AnyCancellable> = []
    var viewModel : RideOptionSegmentModel?
    init() {
        super.init(frame: .zero)
        buildViewHeirarchy()
        
        
        
    }
    
    convenience init(viewModel : RideOptionSegmentModel?){
        self.init()
        self.viewModel = viewModel
        linkViewState()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let rideOptionsStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.turnOffAutoresizingMask()
        return stackView
    }()
    
    
   
    
    func buildViewHeirarchy(){
        addSubview(rideOptionsStackView)
        NSLayoutConstraint.activate([
            rideOptionsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rideOptionsStackView.topAnchor.constraint(equalTo: topAnchor),
            rideOptionsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rideOptionsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    func linkViewState(){
        viewModel?.$viewRideOptionOptionModel
            .sink(receiveValue: { [weak self] rideOptionOptionModels in
                self?.buildRideOptions(rideOptionsOptionsModels : rideOptionOptionModels)
            })
            .store(in: &subscribtions)
    }
    
    func buildRideOptions(rideOptionsOptionsModels : [RideOptionOptionModel]){
        rideOptionsStackView.removeAllArrangedViews()
       rideOptionsOptionsModels.forEach { rideOptionOptionModel in
            let rideOptionView = RideOptionView(viewModel: rideOptionOptionModel)
            self.rideOptionsStackView.addArrangedSubview(rideOptionView)
        }
    }
}
