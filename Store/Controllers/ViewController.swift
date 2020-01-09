//
//  ViewController.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-08.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    
    private lazy var controllers: [UINavigationController] = {
        return [
            configureTabbarItems(title: "Categories", image: UIImage(systemName: "magnifyingglass"), controller: CategoriesViewController())
        ]
    }()
    
    private lazy var content: UIView = {
        let temp = UIView()
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.barTintColor = UIColor.darkGray
        tabBar.tintColor = UIColor.white
        viewControllers = controllers
    }
    
    private func configureTabbarItems(title: String, image: UIImage?, controller: UIViewController) -> UINavigationController {
        let tabbarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        controller.tabBarItem = tabbarItem
        return CustomNavigationController(rootViewController: controller)
    }
    
}
