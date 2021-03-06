//
//  CartViewController.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-08.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import CoreData
import PassKit
import Stripe

protocol TransactionCompletionDelegate: class {
    func transactionCompleted()
}

class CartViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items = [Product]()
    weak var delegate: TransactionCompletionDelegate?
    
    override var viewControllerTitle: String? {
         return "Cart"
     }
     
    override var showsCart: Bool {
         return false
     }
    
    private lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.delegate = self
        temp.dataSource = self
        temp.tableFooterView = UIView()
        temp.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        temp.register(CartProductTableViewCell.self, forCellReuseIdentifier: "CartProductTableViewCell")
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: summaryView.topAnchor).isActive = true
        return temp
    }()
    
    private lazy var summaryView: SummaryView = {
        let temp = SummaryView()
        temp.delegate = self
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
    
    func fetch() {
        Core.shared.fetch(type: Product.self) { [weak self] products in
            self?.items = products
            self?.tableView.reloadData()
            self?.updatePrice()
            self?.toggleBuyButton()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductTableViewCell", for: indexPath) as? CartProductTableViewCell else { return UITableViewCell() }
        let item = items[indexPath.row]
        cell.product = item
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "Remove from cart") { (action, view, completion) in
            completion(true)
            self.removeItemWithIndexPath(indexPath)
        }
        addAction.backgroundColor = UIColor(red: 0.615, green: 0.001, blue: 0.095, alpha: 1.00)
        return UISwipeActionsConfiguration(actions: [addAction])
    }
    
    private func removeItemWithIndexPath(_ indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        Core.shared.delete(object: item)
        self.items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.updatePrice()
        self.toggleBuyButton()
        
        Core.shared.hasProductsInCart { (status, count) in
            if count == 0 {
                self.dismiss(animated: true, completion: nil)
            }
        }

    }
    
    func updatePrice() {
        let totalPrice = items.reduce(0) { $0 + (Double($1.count) * $1.price) }
        summaryView.price = totalPrice
    }
    
    func toggleBuyButton() {
        summaryView.buttonIsEnabled = items.count > 0
    }

}

extension CartViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        hapticFeedBack(style: .medium)
        Core.shared.delete(objects: items)
        dismiss(animated: true, completion: nil) // PKPaymentAuthorizationViewController
        dismiss(animated: true, completion: nil) // CartViewController
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        delay(duration: 0.5) {
            self.delegate?.transactionCompleted()
        }
    }
     
     func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
        print("transaction completed")
     }
    
}

extension CartViewController: PaymentDelegate {
    func didTapBuyButton() {
        let summaryitems = Pay.shared.configureSummaryItems(items)
        Pay.shared.paymentRequest(items: summaryitems, presentingViewController: self)
    }
}

extension CartViewController: CartProductTableViewCellDelegate {
    
    func removeProductAtIndexPath(_ indexPath: IndexPath) {
        Alert.alertWithQuestion(presentingViewController: self, title: "Remove Product", message: "Are your sure you want to remove the product from your cart?", okCompletion: { [weak self] in
            self?.removeItemWithIndexPath(indexPath)
        }) { [weak self] in
            self?.items[indexPath.row].count = 1
            Core.shared.save()
        }
    }
    
    func cartChanged() {
        updatePrice()
    }
    
}
