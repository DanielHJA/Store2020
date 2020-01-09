//
//  TransparentNavigationController.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-09.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class TransparentNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isOpaque = false
        navigationBar.isTranslucent = true
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = UIColor.clear
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
}
