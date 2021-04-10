//
//  RideRequestViewModel.swift
//  MVVM_T
//
//  Created by Hossam on 10/04/2021.
//

import Combine
import Foundation
protocol NewRideResponder {
    func createNewRide()
}
class RideRequestViewModel {
    var subscribtions : Set<AnyCancellable> = []
    internal init(rideRequest: RideRequest, newRideResponder: NewRideResponder, requestRideRepository: RequestingRideRepository) {
        self.rideRequest = rideRequest
        self.newRideResponder = newRideResponder
        self.requestRideRepository = requestRideRepository
    }
    
    
    
    let rideRequest : RideRequest
    let newRideResponder : NewRideResponder
    let requestRideRepository : RequestingRideRepository
    @Published var state : RideRequestState = .requesting
    
    @objc
    func onPressRequestNewRide(){
        newRideResponder.createNewRide()
    }
    
    func onWaitingForPickup(){
        requestRideRepository
            .waitForPickup()
            .sink { [weak self] completed in
                self?.state = completed ? .requestNew : .requesting
            }
            .store(in: &subscribtions)
    }
    
}

protocol RequestingRideRepository {
    func waitForPickup()->AnyPublisher<Bool , Never>
}
enum RideRequestState {
    case requesting
    case requestNew
}

protocol RequestingAPI {
    func getCompletion()->AnyPublisher<Bool , Never>
}
struct KooperRequestingRideRepository  : RequestingRideRepository{
    let requestingAPI : RequestingAPI
    func waitForPickup() -> AnyPublisher<Bool, Never> {
       requestingAPI.getCompletion()
        
    }
    
}

struct FakeRequestingAPI : RequestingAPI {
    func sendRideRequestToServer() {
        print("send To Server")
        
        
    }
    
    func getCompletion() -> AnyPublisher<Bool, Never> {
        sendRideRequestToServer()
       return Just(true)
        .delay(for: .seconds(3), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
}
