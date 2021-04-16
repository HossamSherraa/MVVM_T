//
//  MainDependecyContainer.swift
//  MVVM_T
//
//  Created by Hossam on 16/04/2021.
//

import Foundation
class MainDependencyContrainer : MainViewControllerFactory {
    let mainViewModel : MainViewModel
    let userSessionRepository : UserSessionRepository
    func makeOnBoardingViewController() -> OnboardingViewController {
       let onboardingDependencyContrainer = OnboardingDependencyContrainer(userSessionRepository: userSessionRepository)
        return onboardingDependencyContrainer.makeOnboardingViewController()
    }
    
    func makeSignedInViewController(_ userSession: UserSession) -> SignedInViewController {
        let signedInDependencyContainer = SignedInDependencyContainer(userSessionRepository: userSessionRepository, mainViewModel: mainViewModel)

        return signedInDependencyContainer.makeSignedInViewController()
    }
    
    func makeLaunchViewController() -> LaunchViewController {
        LaunchViewController(factory: self)
    }
    
    func makeMainViewControllerViewModel() -> MainViewModel {
        mainViewModel
    }
    
    init() {
        self.mainViewModel = MainViewModel()
        func makeDataStore()->UserSessionDataStore{
            let coreDataCreator = CoreDataStackCreator()
            return CoreDataDataStore(coreDataCreator: coreDataCreator)
        }
        
        func makeRemoteApi()->UserSessionRemoteApi{
            FakeRemoteApi()
            
        }
        func makeUserSessionRepository()->UserSessionRepository {
            let api = makeRemoteApi()
            let datastore = makeDataStore()
            return KooperUserSessionRepository(datastore: datastore, remoteApi: api)
        }
        self.userSessionRepository = makeUserSessionRepository()
        
    }
    
    func makeMainViewController() -> MainViewController {
        MainViewController(factory: self)
    }
    
}



extension MainDependencyContrainer : LaunchViewControllerFactory {
    func makeLaunchViewModel() -> LaunchViewModel {
        
        LaunchViewModel(userSessionRepository: userSessionRepository, signedInResponder: mainViewModel, signedOutResponder: mainViewModel)
    }
    
    
}
