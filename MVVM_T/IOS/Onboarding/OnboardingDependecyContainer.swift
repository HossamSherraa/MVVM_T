//
//  OnboardingDependecyContainer.swift
//  Kooper_MVVM
//
//  Created by Hossam on 27/03/2021.
//

class OnboardingDependencyContrainer : OnboardingFactory , SigninViewModelFactory, SignUpViewModelFactory , WelcomeViewModelFactory {
//    func makeProfileViewModel() -> ProfileViewModel {
//        ProfileViewModel(userSessionRepository: userSession, userSession: .makeUserSession(profile: .makeUserProfile(name: "Hossam", nickname: "SOSMS", email: "Hossam", password: "Pass"), session: .makeSession(token: "123123123"), state: "signined"), userProfile: .makeUserProfile(name: "Hossam", nickname: "sms", email: "emal", password: "pas"), signoutResponder: onBoardingViewModel, dismissProfileResponder: onBoardingViewModel)
//    }
//
   
    
    
    
    
    let onBoardingViewModel : OnboardingViewModel
    let userSession : UserSessionRepository
    
    
     func makeSigninViewModel() -> SigninViewModel {

       return SigninViewModel(sessionRepository: userSession, signedInResponder: onBoardingViewModel)
    }
    
    func makeWelcomeViewModel() -> WelcomeViewModel {
        WelcomeViewModel(signinResponder: onBoardingViewModel, signupResponder: onBoardingViewModel)
    }
    

    func makeSignupViewModel() -> SignupViewModel {
        SignupViewModel(sessionRepository: userSession, signedInResponder: onBoardingViewModel)
    }
    
    
    func makeSignInViewController() -> SigninViewController {
        SigninViewController(signinViewModelFactory: self)
    }
    
    func makeWelcomeViewController() -> WelcomeViewController {
        WelcomeViewController(welcomeViewModelFactory: self)
    }
    
    func makeSignupViewController() -> SignupViewController {
        SignupViewController(signinViewModelFactory: self)
    }
    

    func makeOnboardingViewController() -> OnboardingViewController {
        return OnboardingViewController(onboardingFactory: self, viewModel: onBoardingViewModel)
    }
    
    init() {
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
        self.userSession = makeUserSessionRepository()
        
        func makeOnBoardingViewModel()->OnboardingViewModel {
            OnboardingViewModel()
        }
        
        self.onBoardingViewModel = makeOnBoardingViewModel()
    }
    
}

