//
//  BaseViewController.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-08.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var viewControllerTitle: String? {
        return nil
    }
    
    var showsCart: Bool {
        return true
    }
    
    private lazy var cartBarButtonItem: UIBarButtonItem = {
        let temp = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(displayCart))
        temp.tintColor = UIColor.white
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = viewControllerTitle
        
        if showsCart {
            navigationItem.rightBarButtonItem = cartBarButtonItem
        }
    }
    
    @objc private func displayCart() {
        DispatchQueue.main.async { [weak self] in
            let controller = CustomNavigationController(rootViewController: CartViewController())
            self?.tabBarController?.present(controller, animated: true, completion: nil)
        }
    }

}
