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
    
    var webServiceURL: String? {
        return nil
    }
    
    private lazy var cartBarButtonItem: BadgedButtonItem = {
        let temp = BadgedButtonItem(with: UIImage(systemName: "cart"))
        temp.tintColor = UIColor.white
        temp.tapAction = {
            self.displayCart()
        }
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = viewControllerTitle
        configureObservers()
        if showsCart { navigationItem.rightBarButtonItem = cartBarButtonItem }
        checkProductsInCart()
    }
    
    private func configureObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: NSNotification.Name("cartUpdated"), object: nil)
    }
    
    @objc private func cartUpdated() {
        checkProductsInCart()
    }
    
    private func checkProductsInCart() {
        File.shared.cartHasItems { [weak self] (status, count) in
            self?.cartBarButtonItem.isEnabled = status
            self?.cartBarButtonItem.badgeValue = count
        }
    }
    
    @objc private func displayCart() {
        DispatchQueue.main.async { [weak self] in
            let controller = CartViewController()
            controller.delegate = self
            let navigationController = CustomNavigationController(rootViewController: controller)
            self?.tabBarController?.present(navigationController, animated: true, completion: nil)
        }
    }

}

extension BaseViewController: TransactionCompletionDelegate {
    func transactionCompleted() {
        let controller = TransparentNavigationController(rootViewController: TransactionCompletionViewController())
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
}
