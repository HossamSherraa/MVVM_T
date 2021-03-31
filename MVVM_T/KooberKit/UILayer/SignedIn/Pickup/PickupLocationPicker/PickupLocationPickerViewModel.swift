//
//  PickupLocationPickerViewModel.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import Combine
import Foundation

protocol PickupLocationPickerDeterminedResponder {
    func pickupLocationPickerDetermined(_ location : Location)
}

protocol PickupLocationPickerDismissedResponder {
    func pickupLocationPickerDismissed()
}

protocol SearchLocationRepository {
    func searchForAvilableLocationsAt( _ query : String)->AnyPublisher<[NamedLocation] , Never>
}

class PickupLocationPickerViewModel {
    internal init(searchLocationRepository: SearchLocationRepository, pickupLocationPickerDeterminedResponder: PickupLocationPickerDeterminedResponder, pickupLocationPickerDismissedResponder: PickupLocationPickerDismissedResponder) {
        self.searchLocationRepository = searchLocationRepository
        self.pickupLocationPickerDeterminedResponder = pickupLocationPickerDeterminedResponder
        self.pickupLocationPickerDismissedResponder = pickupLocationPickerDismissedResponder
        setupBindings()
    }
    
   
    let selectedLocation = PassthroughSubject<Location , Never>()
    @Published var locations : [NamedLocation] = []
    @Published var searchQuery : String? = nil
    
    let searchLocationRepository : SearchLocationRepository
    var subscribtions : Set<AnyCancellable> = .init()
    let pickupLocationPickerDeterminedResponder : PickupLocationPickerDeterminedResponder
    let pickupLocationPickerDismissedResponder : PickupLocationPickerDismissedResponder
    
    
   private func loadAvailableLocations(_ query : String){
        searchLocationRepository.searchForAvilableLocationsAt(query)
            .assign(to: &$locations)
    }
    
    private func bindOnSelectedLocation(){
        selectedLocation
            .sink {[weak self] location in
                self?.pickupLocationPickerDeterminedResponder.pickupLocationPickerDetermined(location)
            }
            .store(in: &subscribtions)
    }
    
    private func bindSearchQuery(){
        $searchQuery
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap{$0}
            .sink {[weak self ] query in
                self?.loadAvailableLocations(query)
            }
            .store(in: &subscribtions)
    }
    
    
    @objc
    func onPressDismiss(){
        pickupLocationPickerDismissedResponder.pickupLocationPickerDismissed()
    }
    
    func setupBindings(){
        bindOnSelectedLocation()
        bindSearchQuery()
    }
    
}


