//
//  PickupLocationPickerRootView.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import UIKit
import Combine
class PickupLocationPickerRootView : UIView {
    
    let viewModel : PickupLocationPickerViewModel
    var subscribtions = Set<AnyCancellable>.init()
     init(viewModel : PickupLocationPickerViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViewHeirarchy()
        subscribeToLocations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
   private func setupViewHeirarchy(){
        addSubview(tableView)
    }
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
      resizeToSuperView(view: tableView)
    }
    
   private func subscribeToLocations(){
        viewModel.$locations
            .sink { [weak self]_ in
                self?.tableView.reloadData()
            }
            .store(in: &subscribtions)
    }
    
    
}

extension PickupLocationPickerRootView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell =  tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = viewModel.locations[indexPath.row].name
        return cell
    }
}


extension PickupLocationPickerRootView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = viewModel.locations[indexPath.row].location
        viewModel.selectedLocation = selectedLocation
    }
}
