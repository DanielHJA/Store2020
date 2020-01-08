//
//  DataExtensions.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-08.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

extension Data {
    func decode<T: Decodable>() -> T? {
        let decoder = JSONDecoder()
        do {
            let items = try decoder.decode(T.self, from: self)
            return items
        } catch let error {
            print(error)
        }
        return nil
    }
}
