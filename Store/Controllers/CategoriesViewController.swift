//
//  CategoriesViewController.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-09.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CategoriesViewController: BaseTableViewViewController<ProductContainer> {

    override var webServiceURL: String? {
        return "http://demo6427581.mockable.io/"
    }
    
    override var viewControllerTitle: String? {
        return "Kategorier"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as? CategoriesTableViewCell else { return UITableViewCell() }
        let item = items[indexPath.row]
        cell.configure(item.title)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        let controller = ProductListViewController()
        controller.items = [items[indexPath.row]]
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
