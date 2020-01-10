//
//  Pay.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-08.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import PassKit

class Pay: NSObject {
    static let shared = Pay()
    private override init() {}
    
    let paymentNetworks: [PKPaymentNetwork] = [.amex, .discover, .masterCard, .visa]
    
    func configureSummaryItem(_ item: Product) -> PKPaymentSummaryItem? {
        return PKPaymentSummaryItem(label: item.name, amount: NSDecimalNumber(value: item.price))
    }
    
    func configureSummaryItems(_ items: [Product]) -> [PKPaymentSummaryItem] {
        var tempArray = [PKPaymentSummaryItem]()
        for item in items {
            let current = PKPaymentSummaryItem(label: item.name, amount: NSDecimalNumber(value: item.price))
                tempArray.append(current)
            }
        return tempArray
    }
    
    func paymentRequest(items: [PKPaymentSummaryItem], presentingViewController: UIViewController & PKPaymentAuthorizationViewControllerDelegate) {
        if PKPaymentAuthorizationController.canMakePayments(usingNetworks: paymentNetworks) {
            let request = PKPaymentRequest()
            request.currencyCode = "USD"
            request.countryCode = "US"
            request.merchantIdentifier = "merchant.com.daniel.hjartstrom.Store"
            request.merchantCapabilities = .capability3DS
            request.requiredBillingContactFields = [.postalAddress, .name, .phoneNumber]
            request.supportedNetworks = paymentNetworks
            request.paymentSummaryItems = items
            
            guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
                print("PKPaymentAuthorizationViewController failed")
                return
            }
            
            paymentVC.delegate = presentingViewController
            presentingViewController.present(paymentVC, animated: true, completion: nil)
            
        } else {
            print("Unable to make payments")
        }
    }
    
}
