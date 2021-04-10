//
//  RideOptionView.swift
//  MVVM_T
//
//  Created by Hossam on 03/04/2021.
//

import UIKit
import Combine
class RideOptionView : UIView  {
    var subscriptions: Set<AnyCancellable> = []
    
    var viewModel : RideOptionOptionModel?
    init() {
        super.init(frame: .zero)
        buildViewHeirarchy()
        buildConstraints()
        
        
    }
    
    convenience init(viewModel : RideOptionOptionModel){
        self.init()
        self.viewModel = viewModel
        linkViewState()
        linkViewActionsToViewModel()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   private let namelabel : UILabel = {
        let lable = UILabel()
        lable.text = "Grand"
        lable.turnOffAutoresizingMask()
        lable.textColor = .white
        lable.font = .systemFont(ofSize: 17, weight: .semibold)
        return lable
    }()
    
   private let iconImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "roo-icon")
        imageView.turnOffAutoresizingMask()
        return imageView
    }()
    
    
   private func configStyle(){
       configIconImageStyle()
        configViewStyle()
    }
    
    private func configIconImageStyle(){
        iconImage.layer.cornerRadius = iconImage.frame.height / 2
        iconImage.layer.masksToBounds = true
    }
    
    private func configViewStyle(){
        self.backgroundColor = #colorLiteral(red: 0, green: 0.1867271364, blue: 0.3922301829, alpha: 1)
        layer.cornerRadius =  self.frame.width / 2
    }
    
    private func buildViewHeirarchy(){
        self.addSubview(iconImage)
        self.addSubview(namelabel)
    }
    
    private func buildConstraints(){
        NSLayoutConstraint.activate([
        //ContainerViewHeight
           
            widthAnchor.constraint(equalToConstant: 65),
            heightAnchor.constraint(equalToConstant: 120),
            iconImage.topAnchor.constraint(equalTo: topAnchor , constant: -10),
            iconImage.widthAnchor.constraint(equalTo: widthAnchor, constant: 20),
            iconImage.heightAnchor.constraint(equalTo: widthAnchor, constant: 20),
            iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomAnchor.constraint(equalTo:namelabel.bottomAnchor , constant: 30 ),
            namelabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        //
        ])
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configStyle()
        
    }
    
    func linkViewActionsToViewModel (){
        attachTapGesture()
        
    }
    
    func linkViewState(){
        viewModel?.$isSelected
            .sink(receiveValue: { [weak self] isSelected in
                self?.iconImage.image = isSelected ? self?.viewModel?.rideImage.getSelected: self?.viewModel?.rideImage.getUnselected
            })
            .store(in: &subscriptions)
        
        
        viewModel?.$name.sink(receiveValue: { [weak self] text in
            self?.namelabel.text = text
        })
        .store(in: &subscriptions)
        
    }
    
    func attachTapGesture(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: viewModel, action: #selector(self.viewModel?.onSelect))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
   
    
    
}

