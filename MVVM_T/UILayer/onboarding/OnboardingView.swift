//
//  OnboardingView.swift
//  Kooper_MVVM
//
//  Created by Hossam on 27/03/2021.
//

enum OnboardingView : String, Equatable, Identifiable, CustomStringConvertible {
    var id: String {
        self.rawValue
    }
    
    var description: String {
        self.rawValue
    }
    
    case signin , signup , welcome , none
}
