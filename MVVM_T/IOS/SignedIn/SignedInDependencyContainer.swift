//
//  SignedInDependencyContainer.swift
//  MVVM_T
//
//  Created by Hossam on 06/04/2021.
//

import Combine
import Foundation
let testUserSession = UserSession.makeUserSession(profile: .makeUserProfile(name: "Hossam", nickname: "smsm", email: "smsm@sms.com", password: "passw"), session: .makeSession(token: "56434"), state: "signedin")


struct FakeLocator : Locator{
    func getUserLocation() -> AnyPublisher<Location, Never> {
        Just(Location(latitude: 30.12251, longitude: 31.14445))
            .delay(for: 2, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
}
class SignedInDependencyContainer : SignedInViewControllerFactory , ProfileViewControllerFactory , LocationGetterFactory , RideRequestViewControllerFactory {
    func makeRequestingRideAPI()->RequestingAPI{
        FakeRequestingAPI()
    }
    func makeRequestingRideRepository()->RequestingRideRepository {
        let requestingAPI = makeRequestingRideAPI()
        return KooperRequestingRideRepository(requestingAPI: requestingAPI)
    }
    func makeRideRequestViewModel(rideRequest: RideRequest) -> RideRequestViewModel {
        let requestRideRepository  = makeRequestingRideRepository()
        return .init(rideRequest: rideRequest, newRideResponder: signedInViewModel, requestRideRepository: requestRideRepository)
    }
    
    func makeRideRequestViewController(_ rideRequest: RideRequest) -> RideRequestViewController {
        RideRequestViewController(rideRequestViewControllerFactory: self, rideRequest: rideRequest)
    }
    
   
    
    func makePickupViewController(_ location: Location) -> PickupViewController {
        let pickupContainer = PickupViewControllerDependencyContainer(location: location, signedInViewModel: signedInViewModel)
        return PickupViewController(pickViewControllerFactory: pickupContainer, location: location)
    }
    
    func makeLocationGetterViewModel() -> LocationViewModel {
        let locator = makeLocator()
        return LocationViewModel(locator: locator, pickupLocationDeterminedResponder: signedInViewModel)
    }
    
    
    func makeLocator()->Locator {
        FakeLocator()
    }
    let signedInViewModel : SignedInViewModel
    
    func signedIn(userSession: UserSession) {
        //Test
    }
    
    func signedout() {
        //Test
    }
    
    let onBoardingDependencyContainer : OnboardingDependencyContrainer
    init(onBoardingDependencyContainer : OnboardingDependencyContrainer) {
        self.onBoardingDependencyContainer = onBoardingDependencyContainer
        self.signedInViewModel = SignedInViewModel()
    }
    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(userSessionRepository: onBoardingDependencyContainer.userSessionRepository, userSession: testUserSession, userProfile: testUserSession.userProfile!, signoutResponder: self, dismissProfileResponder: signedInViewModel)
    }
    
    func makeProfileViewController() -> ProfileViewController {
        ProfileViewController(profileViewControllerFactory: self)
    }
    
    func makeLocationGetterViewController() -> LocationGetterViewController {
        LocationGetterViewController(locationGetterFactory: self)
    }
    
    func makeSignedInViewModel() -> SignedInViewModel {
        return self.signedInViewModel
    }
    
    
}

//Test
extension SignedInDependencyContainer :  SignedInResponder , SignoutResponder {}


class PickupViewControllerDependencyContainer : PickupViewControllerFactory , PickupLocationPickerFactory , RideOptionsViewControllerFactory , MapViewControllerFactory{
    
    func makeMapViewModel() -> MapViewModel {
     mapViewModel
    }
    
    func makePickupViewModel() -> PickupViewModel {
       pickupViewModel
    }
    
    func makeRideOptionsViewModel() -> RideOptionViewModel {
        return .init(rideOptionsRepository: TestRideOptionsRepository(), rideOptionSegmentModel: RideOptionSegmentModel(imageLoader: RideOptionsSigmentImageLoader(imageCache: BundleImageCache())), pickupLocation: .init(latitude: 31.00, longitude: 32.00), confirmRideOptionResponder: pickupViewModel)
    }
    
    let location : Location
    let pickupViewModel : PickupViewModel
    let signedInViewModel : SignedInViewModel
    let mapViewModel : MapViewModel
    
    init(location : Location , signedInViewModel : SignedInViewModel) {
        self.signedInViewModel = signedInViewModel
        self.location = location
        self.mapViewModel =  MapViewModel(location: location)
        
           
        
        self.pickupViewModel =  PickupViewModel(location: .init(latitude: 30, longitude: 30), requestRideRepository: FakeRequestRideRepository(), requestRideResponder: signedInViewModel)
        
    }
    
    func makeMapViewController() -> MapViewController {
        MapViewController(location: location, mapViewControllerFactory: self)
    }
    
    func makePickupLocationPicker() -> PickupLocationPickerViewController {
        PickupLocationPickerViewController(pickupLocationPickerFactory: self)
    }
    
    func rideOptionsViewController() -> RideOptionsViewController {
        RideOptionsViewController(rideOptionsViewControllerFactory: self)
    }
    
    func makePickupLocationPickerViewModel() -> PickupLocationPickerViewModel {
        .init(searchLocationRepository: FakeSearchLocationRepository(), pickupLocationPickerDeterminedResponder: pickupViewModel, pickupLocationPickerDismissedResponder: pickupViewModel, mapPickupLocationDeterminedResponder: mapViewModel)
    }
    
    func makeSearchRepository()->SearchLocationRepository {
       return FakeSearchLocationRepository()
    }
    
   
    
    
}

struct FakeSearchLocationRepository : SearchLocationRepository {
    func searchForAvilableLocationsAt(_ query: String) -> AnyPublisher<[NamedLocation], Never> {
        let namesLocations : [NamedLocation] = [
            .init(location: .init(latitude:  31.12251, longitude:  31.12251), name: "Opera"),
            .init(location: .init(latitude: 26.00, longitude: 28.00), name: "Metro")
        ]
        return Just(namesLocations)
            .eraseToAnyPublisher()
    }
    
    
}

struct FakeRequestRideRepository : RequestRideRepository {
    func createRideRequest(dropOffLocation: Location, pickupLocation: Location, rideOptionID: RideOptionID) -> AnyPublisher<RideRequest, Never> {
        let rideRequest = RideRequest(pickupLocation: pickupLocation, dropOffLocation: dropOffLocation, rideOption: rideOptionID)

       return Just(rideRequest)
            .eraseToAnyPublisher()
    }
    
    
}


