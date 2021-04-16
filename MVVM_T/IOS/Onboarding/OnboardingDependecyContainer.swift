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
    let userSessionRepository : UserSessionRepository
    
    
     func makeSigninViewModel() -> SigninViewModel {

       return SigninViewModel(sessionRepository: userSessionRepository, signedInResponder: onBoardingViewModel)
    }
    
    func makeWelcomeViewModel() -> WelcomeViewModel {
        WelcomeViewModel(signinResponder: onBoardingViewModel, signupResponder: onBoardingViewModel)
    }
    

    func makeSignupViewModel() -> SignupViewModel {
        SignupViewModel(sessionRepository: userSessionRepository, signedInResponder: onBoardingViewModel)
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
    
    init(userSessionRepository : UserSessionRepository) {
        self.userSessionRepository = userSessionRepository
        
        func makeOnBoardingViewModel()->OnboardingViewModel {
            OnboardingViewModel()
        }
        
        self.onBoardingViewModel = makeOnBoardingViewModel()
    }
    
}

