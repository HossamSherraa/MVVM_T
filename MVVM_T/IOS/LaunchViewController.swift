//
//  LaunchViewController.swift
//  MVVM_T
//
//  Created by Hossam on 16/04/2021.
//

import UIKit
import Combine
class LaunchViewController : NiblessViewController {

    let viewModel : LaunchViewModel
    override func loadView() {
        view = LaunchRootView(viewModel: viewModel)
    }
    
    init(factory : LaunchViewControllerFactory) {
        viewModel = factory.makeLaunchViewModel()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
protocol LaunchViewControllerFactory {
    func makeLaunchViewModel()->LaunchViewModel
}

class LaunchRootView : UIView{
    var viewModel : LaunchViewModel?
    convenience init(viewModel : LaunchViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Color.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        viewModel?.readCurrentSignedInUser()
    }
}

class LaunchViewModel {
    internal init(userSessionRepository: UserSessionRepository, signedInResponder: SignedInResponder, signedOutResponder: SignoutResponder) {
        self.userSessionRepository = userSessionRepository
        self.signedInResponder = signedInResponder
        self.signedOutResponder = signedOutResponder
    }
    
    let userSessionRepository : UserSessionRepository
    let signedInResponder : SignedInResponder
    let signedOutResponder : SignoutResponder
    
    var subscriptions : Set<AnyCancellable> = []
    
    func readCurrentSignedInUser(){
        userSessionRepository.readCurrentUser()
            .sink { [weak self] userSession in
                
                if let userSession = userSession {
                    self?.signedInResponder.signedIn(userSession: userSession)
                }else {
                    self?.signedOutResponder.signedout()
                }
            }
            .store(in: &subscriptions)
    }
    
    
}
