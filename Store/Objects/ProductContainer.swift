//
//  Section.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-07.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

struct ProductContainer: Decodable {

    var title: String
    var products: [Product]
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case products = "products"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        products = try container.decode([Product].self, forKey: .products)
    }
    
}
