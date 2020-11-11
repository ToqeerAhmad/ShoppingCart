//
//  ProductDetailViewController.swift
//  ShoppingCart
//
//  Created by toq33r on 11/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    // Public Variable to show product detail
    var productDetail: ProductModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    // Push to Cart screen
    @IBAction func showCartScreen() {
        // Add product to Cart Array
        SharedUtility.poductList.append(productDetail)
        let cartViewController = self.storyboard?.instantiateViewController(identifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(cartViewController, animated: true)
    }
}

extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartCell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! ProductDetailTableViewCell
        cartCell.setUpDetailCell(productDetail)
        return cartCell
    }
}

extension ProductDetailViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.SCREENHEIGHT-64
    }
}
