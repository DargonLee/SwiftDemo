//
//  FBTableViewController.swift
//  SwiftDemo
//
//  Created by Harlan on 2020/4/23.
//  Copyright © 2020 Harlan. All rights reserved.
//

import UIKit

class FBTableViewController: UITableViewController {

    typealias RowModel = [String: String]
    
    private var user: FBMeUser {
        get {
            return FBMeUser(name: "BayMax", education: "CMU")
        }
    }
    
    private var tableViewDataSource: [[String: Any]] {
        get {
            return TableKeys.populate(withUser: user)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Facebook"
        navigationController?.navigationBar.barTintColor = Specs.color.tint
        tableView.register(FBMeBaseCell.self, forCellReuseIdentifier: FBMeBaseCell.identifier)
    }
    
    private func rows(at section: Int) -> [Any] {
        return tableViewDataSource[section][TableKeys.Rows] as! [Any]
    }
    
    private func title(at section: Int) -> String? {
        return tableViewDataSource[section][TableKeys.Section] as? String
    }
    
    private func rowModel(at indexPath: IndexPath) -> RowModel {
        return rows(at: indexPath.section)[indexPath.row] as! RowModel
    }

}

// MARK: - Table view data source
extension FBTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
      return tableViewDataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return rows(at: section).count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return title(at: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let modelForRow = rowModel(at: indexPath)
        guard let title = modelForRow[TableKeys.Title] else {
            return 0.0
        }
        if title == user.name {
            return 64.0
        }
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelForRow = rowModel(at: indexPath)
        var cell = UITableViewCell()
        guard let title = modelForRow[TableKeys.Title] else {
            return cell
        }
        if title == user.name {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        }else {
            cell = tableView.dequeueReusableCell(withIdentifier: FBMeBaseCell.identifier, for: indexPath)
        }
        cell.textLabel?.text = title
        if let imageName = modelForRow[TableKeys.ImageName] {
            cell.imageView?.image = UIImage(named: imageName)
        }else if title != TableKeys.Logout {
            cell.imageView?.image = UIImage(named: Specs.imageName.placeholder)
        }
        if title == user.name {
            cell.detailTextLabel?.text = modelForRow[TableKeys.SubTitle]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let modelForRow = rowModel(at: indexPath)
        guard let title = modelForRow[TableKeys.Title] else {
            return
        }
        if title == TableKeys.Title || title == TableKeys.AddFavorites {
            cell.textLabel?.textColor = Specs.color.tint
            cell.accessoryType = .none
        }else if title == TableKeys.Logout {
            cell.textLabel?.textColor = Specs.color.red
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
            cell.textLabel?.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        }else {
            cell.accessoryType = .disclosureIndicator
        }
    }
    
}
