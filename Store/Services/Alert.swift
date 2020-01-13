//
//  Alert.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-10.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class Alert: NSObject {

    class func alertWithQuestion(presentingViewController: UIViewController, title: String, message: String, okCompletion: @escaping () -> Void, cancelCompletion: @escaping () -> Void) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .destructive) { (action) in
            okCompletion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            cancelCompletion()
        }
        controller.addAction(okAction)
        controller.addAction(cancelAction)
        presentingViewController.present(controller, animated: true, completion: nil)
    }
    
}
