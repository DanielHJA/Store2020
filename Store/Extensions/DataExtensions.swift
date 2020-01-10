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

extension Encodable {

    func encoded() -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func json() -> String? {
        guard let data = encoded() else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
}
