//
//  NSManagedObjectExtensions.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-08.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import CoreData

extension NSManagedObject {
    static var identifier: String {
        return String(describing: self)
    }
}

extension Product {
    func setCount(_ value: Int) {
        self.count = Int32(value)
        Core.shared.save()
    }
}
