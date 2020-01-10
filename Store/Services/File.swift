//
//  FileManager.swift
//  Store
//
//  Created by Daniel Hjärtström on 2020-01-10.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class File: NSObject {
    static let shared = File()
    
    private var fileManager = FileManager.default
    
    private lazy var cartURL: URL = {
        return userDirectory.appendingPathComponent("cart.json")
    }()
    
    private lazy var userDirectory: URL = {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }()
    
    private var cart = Cart()
    
    func initCart() {
        if !fileManager.fileExists(atPath: cartURL.path) {
            saveProducts([])
        }
    }
    
    func clearCart() {
        saveProducts([])
    }
    
    func saveProducts(_ products: [Product]) {
        cart.products = products
        guard let data = cart.encoded() else { return }
        if fileManager.fileExists(atPath: cartURL.path) {
            do {
                try fileManager.removeItem(at: cartURL)
            } catch let error {
                print(error)
            }
        }
        fileManager.createFile(atPath: cartURL.path, contents: data, attributes: nil)
    }
    
    func fetchCart(completion: @escaping ([Product]) -> Void) {
        if let data = fileManager.contents(atPath: cartURL.path) {
            if let decodedData: Cart = data.decode() {
                completion(decodedData.products)
            }
        }
    }
    
    func cartHasItems(completion: @escaping (Bool, Int) -> Void) {
          if let data = fileManager.contents(atPath: cartURL.path) {
            if let cart: Cart = data.decode() {
                completion(cart.products.count > 0, cart.products.count)
            }
        }
    }
    
    func delete(filename: String, of type: String) {
        do {
            try fileManager.removeItem(at: cartURL)
        } catch let error {
            print(error)
        }
    }
    
    func addToCart(_ product: Product) {
        fetchCart { (products) in
            var temp = products
            temp.append(product)
            File.shared.saveProducts(temp)
        }
    }
    
}
