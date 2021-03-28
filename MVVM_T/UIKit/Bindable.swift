//
//  Bindable.swift
//  MVVM_T
//
//  Created by Hossam on 28/03/2021.
//

import Combine
import UIKit
protocol Bindable : UIView {
    associatedtype ViewModel
    var viewModel : ViewModel {get set}
    var subscriptions : Set<AnyCancellable> {get set}
}

extension Bindable {
    var subscriptions : Set<AnyCancellable> {
        return .init()
    }
    func bindTextFieldText(_ textField : UITextField , to : WritableKeyPath<ViewModel , String> ){
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
            .sink(receiveValue: { _ in
                self.viewModel[keyPath: to] =  textField.text ?? ""
            })
            .store(in: &subscriptions)
        
    }
    
    func bindState<T:UIView>(to component : T , uiComponents : ReferenceWritableKeyPath<T , Bool> , state : KeyPath<ViewModel , Published<Bool>.Publisher>){
        self.viewModel[keyPath: state]
            .assign(to: uiComponents, on: component)
            .store(in: &subscriptions)
    }
}
