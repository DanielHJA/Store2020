//
//  Cart.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-10.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import CoreData

struct Cart: Codable {

    var products: [Product]
    
    private enum CodingKeys: String, CodingKey {
        case products = "products"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        products = try container.decode([Product].self, forKey: .products)        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(products, forKey: .products)
    }
    
    init() {
        self.products = []
    }
    
}




