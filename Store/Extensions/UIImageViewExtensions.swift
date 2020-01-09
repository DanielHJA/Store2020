//
//  UIImageViewExtensions.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-08.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadAsync(_ url: URL?) {
        image = UIImage(named: "imagePlaceholder")
        DispatchQueue.global().async {
            guard let url = url else { return }
            do {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
