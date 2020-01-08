//
//  Webservice.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-07.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class Webservice<T: Decodable> {

    class func fetch(url: String?, completion: @escaping (T) -> Void) {
        guard let urlString = url else { return }
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let decodedData: T = data?.decode() {
                completion(decodedData)
            }
        }.resume()
    }
    
}




