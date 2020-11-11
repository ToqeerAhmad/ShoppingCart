//
//  ProductModel.swift
//  ShoppingCart
//
//  Created by toq33r on 09/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import Foundation

//class ProductModel: NSObject {
//
//}

struct ProductModel: Codable {
    
    var productID: Int
    var title: String = ""
    var productDescription: String = ""
    var filename: String = ""
    let price: Double?
    var category: String = ""
    
    var quantity: Int = 1
    
    init() {
        productID = 0
        title = ""
        productDescription = ""
        filename = ""
        price = 0
        category = ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case productID = "id"
        case title = "title"
        case productDescription = "description"
        case filename = "image"
        case price = "price"
        case category = "category"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.productID = try container.decode(Int.self, forKey: .productID)
        self.title = try container.decode(String.self, forKey: .title)
        self.productDescription = try container.decode(String.self, forKey: .productDescription)
        self.filename = try container.decode(String.self, forKey: .filename)
        self.price = try container.decode(Double.self, forKey: .price)
        self.category = try container.decode(String.self, forKey: .category)
    }
}
