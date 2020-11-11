//
//  SharedUtility.swift
//  ShoppingCart
//
//  Created by toq33r on 11/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import Foundation

class SharedUtility: NSObject {

    // Static Array to get and set cart products
    static var poductList: [ProductModel] {
        get {
            if let data = UserDefaults.standard.object(forKey: "products") as? Data {
                return getItem(item: [ProductModel].self, data: data) ?? []
            }
            return []
        }
        set {
            // Encode products and save in UserDefaults
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "products")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    // Decode products saved in UserDefaults
    static private func getItem<T: Codable> (item: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(item.self, from: data)
    }
}
