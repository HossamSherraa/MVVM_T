//
//  ProfileRootView.swift
//  MVVM_T
//
//  Created by Hossam on 30/03/2021.
//

import UIKit
import Combine
class ProfileRootView : UIView , Bindable{
    var subscriptions: Set<AnyCancellable> = .init()
    var viewModel: ProfileViewModel
    var profileViewData : [String?] = []
    typealias ViewModel = ProfileViewModel
    
    lazy var  detailsTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.turnOffAutoresizingMask()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
       
    }()
    
     init(viewModel : ProfileViewModel ) {
        self.viewModel = viewModel
        self.profileViewData = viewModel.userProfileData()
        super.init(frame: .zero)
        buildHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy(){
        addSubview(detailsTableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        detailsTableView.frame = frame
    }
}

extension ProfileRootView : UITableViewDataSource  , UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch  section {
        case 0: return profileViewData.count
        case 1: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        switch indexPath.section {
        case 0: cell.textLabel?.text = profileViewData[indexPath.row]
        case 1 :
            cell.textLabel?.text = "Signout"
            cell.textLabel?.textColor = UIColor.red
        default: break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 0 {
            viewModel.onPressSignout()
        }
    }

    
    
}
