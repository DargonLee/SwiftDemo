//
//  ProductsTableViewController.swift
//  SwiftDemo
//
//  Created by Harlan on 2020/4/1.
//  Copyright © 2020 Harlan. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {

    private var products: [Product]?
    private let cellIdentifer = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
    }
    
    private func setup() {
        products = [
            Product(name: "1907 Wall Set", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
            Product(name: "1921 Dial Phone", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
            Product(name: "1937 Desk Set", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
            Product(name: "1984 Moto Portable", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4")
        ];
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
    }
    
    // MARK: - View Transfer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProduct" {
            if let indexPath = sender as? IndexPath,
            let productVC = segue.destination as? ProductViewController {
                productVC.product = products?[indexPath.row]
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        guard let products = products else {
            return cell
        }
        cell.textLabel?.text = products[indexPath.row].name
        if let imageName = products[indexPath.row].cellImageName {
            cell.imageView?.image = UIImage(named: imageName)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showProduct", sender: indexPath)
    }

}
