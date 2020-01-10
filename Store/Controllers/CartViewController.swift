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

class CartViewController: BaseTableViewViewController<Product> {
    
    weak var delegate: TransactionCompletionDelegate?
    
    override var viewControllerTitle: String? {
         return "Cart"
     }
     
    override var showsCart: Bool {
         return false
     }

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
    
    override func fetch() {
        File.shared.fetchCart { [weak self] (products) in
            self?.items = products
            self?.tableView.reloadData()
            self?.updatePrice()
            self?.toggleBuyButton()
        }
    }
    
    override func registerCells() {
        tableView.register(CartProductTableViewCell.self, forCellReuseIdentifier: "CartProductTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductTableViewCell", for: indexPath) as? CartProductTableViewCell else { return UITableViewCell() }
        let item = items[indexPath.row]
        cell.delegate = self
        cell.indexPath = indexPath
        cell.configure(item) 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "Remove from cart") { (action, view, completion) in
            completion(true)
            self.removeProductFromCart(indexPath: indexPath)
        }
        addAction.backgroundColor = UIColor(red: 0.615, green: 0.001, blue: 0.095, alpha: 1.00)
        return UISwipeActionsConfiguration(actions: [addAction])
    }
    
    private func removeProductFromCart(indexPath: IndexPath) {
        self.items.remove(at: indexPath.row)
        File.shared.saveProducts(self.items)
        NotificationCenter.default.post(name: NSNotification.Name("cartUpdated"), object: nil, userInfo: nil)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.updatePrice()
        self.toggleBuyButton()
        
        if self.items.count == 0 {
            self.delay(duration: 0.5) {
                 self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func updatePrice() {
        let totalPrice = items.reduce(0) { $0 + $1.price }
        summaryView.price = totalPrice
    }
    
    private func toggleBuyButton() {
        summaryView.buttonIsEnabled = items.count > 0
    }

}

extension CartViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        hapticFeedBack(style: .medium)
        File.shared.clearCart()
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
        Alert.alertWithQuestion(presentingViewController: self, title: "Remove Product", message: "Are you sure you want to remove this product from your cart?", okCompletion: {
            self.removeProductFromCart(indexPath: indexPath)
        }, cancelCompletion: {
            
        })
    }
}
