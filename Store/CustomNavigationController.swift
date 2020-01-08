//
//  CustomNavigationController.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-08.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBarsOnSwipe = false
        navigationBar.isOpaque = false
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = UIColor.darkGray
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
    }

}
