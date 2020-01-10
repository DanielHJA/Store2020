//
//  ViewController.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-07.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ProductListViewController: BaseTableViewViewController<ProductContainer> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = items.first?.title
    }
    
    override func registerCells() {
        super.registerCells()
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        let item = items[indexPath.section].products[indexPath.row]
        cell.configure(item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
    }
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "Add to cart") { (action, view, completion) in
            completion(true)
            let item = self.items[indexPath.section].products[indexPath.row]
            File.shared.addToCart(item)
            NotificationCenter.default.post(name: NSNotification.Name("cartUpdated"), object: nil, userInfo: nil)
        }
        addAction.backgroundColor = UIColor(red: 0.000, green: 0.572, blue: 0.000, alpha: 1.00)
        return UISwipeActionsConfiguration(actions: [addAction])
    }
    
}

