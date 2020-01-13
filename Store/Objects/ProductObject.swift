//
//  Product.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-07.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import CoreData

struct ProductObject: Decodable {

    var id: String
    var name: String
    var price: Double
    var thumbnail: URL?
    var productDescription: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case thumbnail = "thumbnail"
        case productDescription = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Double.self, forKey: .price)
        thumbnail = try container.decode(URL.self, forKey: .thumbnail)
        productDescription = try container.decode(String.self, forKey: .productDescription)
    }
    
    init(id: String, name: String, price: Double, thumbnail: URL?, productDescription: String) {
        self.id = id
        self.name = name
        self.price = price
        self.thumbnail = thumbnail
        self.productDescription = productDescription
    }
    
}

extension ProductObject {
    func addToCart() {
        Core.shared.checkIfObjectExist(type: Product.self, parameter: "id", value: self.id) { (exists) in
            if exists {
                let predicate = NSPredicate(format: "id = %@", self.id)
                Core.shared.fetch(type: Product.self, predicate: predicate) { (products) in
                    guard let product = products.first else { return }
                    product.setCount(Int(product.count + 1))
                }
            } else {
                Core.shared.add(type: Product.self) { (product) in
                    product.id = self.id
                    product.count = 1
                    product.name = self.name
                    product.price = self.price
                    product.thumbnail = self.thumbnail
                    product.productDescription = self.productDescription
                    Core.shared.save()
                }
            }
        }
    }
}


