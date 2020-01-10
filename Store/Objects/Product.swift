//
//  Product.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-07.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import CoreData

struct Product: Codable {

    var id: Int
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
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Double.self, forKey: .price)
        thumbnail = try container.decode(URL.self, forKey: .thumbnail)
        productDescription = try container.decode(String.self, forKey: .productDescription)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(productDescription, forKey: .productDescription)
    }
    
}



