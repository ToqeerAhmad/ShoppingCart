//
//  ProductsAPiManager.swift
//  ShoppingCart
//
//  Created by toq33r on 09/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import Foundation
import Alamofire

class ProductsAPiManager: NSObject {

    private override init() {
        super.init()
    }
    static var shared = ProductsAPiManager()
    
    // API to get list of products
    func fetchProductsList(success: @escaping ((_ result: [ProductModel]) -> Void), failure: @escaping ((_ errorMessage: String) -> Void)) {
        
        let url = Constants.baseUrl
                
        AF.request(url, method: .get, parameters: nil,encoding: URLEncoding.default, headers: nil).response {
            response in
            switch response.result {
            case .success:
                if response.data != nil {
                    do {
                        let products = try JSONDecoder().decode([ProductModel].self, from: response.data!)
//                            print(products)
                            success(products)
                    } catch {
                        failure(error.localizedDescription)
                    }
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
