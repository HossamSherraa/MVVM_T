//
//  RideOptionView.swift
//  MVVM_T
//
//  Created by Hossam on 03/04/2021.
//

import UIKit
class RideOptionView : UIView {
    init() {
        super.init(frame: .zero)
        buildViewHeirarchy()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   private let namelabel : UILabel = {
        let lable = UILabel()
        lable.text = "Grand Twoer"
        lable.turnOffAutoresizingMask()
        lable.textColor = .white
        lable.font = .systemFont(ofSize: 13, weight: .semibold)
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
           
            widthAnchor.constraint(equalToConstant: 80),
            heightAnchor.constraint(equalToConstant: 120),
            iconImage.topAnchor.constraint(equalTo: topAnchor , constant: -10),
            iconImage.widthAnchor.constraint(equalTo: widthAnchor, constant: 20),
            iconImage.heightAnchor.constraint(equalTo: widthAnchor, constant: 20),
            iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            bottomAnchor.constraint(equalTo:namelabel.bottomAnchor , constant: 20 ),
            namelabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        //
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configStyle()
        
    }
    
    func configViewWith(rideOptionOptionView : TestOptionOptionModel){
        self.iconImage.image = UIImage(named: rideOptionOptionView.selectedImage)
        self.namelabel.text = rideOptionOptionView.name
    }
    
    
}

