//
//  PickupLocationPickerViewContentController.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import UIKit
class PickupLocationPickerViewContentController : NiblessViewController  , UISearchResultsUpdating{
    let viewModel : PickupLocationPickerViewModel
    
    init(pickupLocationPickerFactory : PickupLocationPickerFactory) {
        viewModel = pickupLocationPickerFactory.makePickupLocationPickerViewModel()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchQuery = searchController.searchBar.text
    }
    
    override func loadView() {
      view = PickupLocationPickerRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationItem()
        configSearchController()
    }
    
    func configNavigationItem(){
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Pick Location"
    }
    
    func configSearchController(){
         let searchViewController = UISearchController(searchResultsController: nil)
         searchViewController.searchResultsUpdater = self
         self.navigationItem.searchController = searchViewController
    }
    
}

protocol PickupLocationPickerFactory{
    func makePickupLocationPickerViewModel()->PickupLocationPickerViewModel
}


