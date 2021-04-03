//
//  RideOptionsStack.swift
//  MVVM_T
//
//  Created by Hossam on 03/04/2021.
//

import UIKit
struct TestOptionOptionModel {
    let name : String = "Option1"
    let selectedImage = "available_wallabe_marker"
    let unselectedImage = "available_kangaroo_marker"
}
class RideOptionContainerView : UIView {
    
    init() {
        super.init(frame: .zero)
        buildViewHeirarchy()
        buildRideOptions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var rideOptionOptionModel : [TestOptionOptionModel] = Array.init(repeating: TestOptionOptionModel(), count: 3)
    
    let rideOptionsStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        
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
    
    func buildRideOptions(){
        rideOptionsStackView.removeAllArrangedViews()
        rideOptionOptionModel.forEach { rideOptionOptionModel in
            let rideOptionView = RideOptionView()
            rideOptionView.configViewWith(rideOptionOptionView: rideOptionOptionModel)
            self.rideOptionsStackView.addArrangedSubview(rideOptionView)
        }
    }
}
