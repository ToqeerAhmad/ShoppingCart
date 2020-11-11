//
//  CartViewController.swift
//  ShoppingCart
//
//  Created by toq33r on 10/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import UIKit
import MBProgressHUD
class CartViewController: UIViewController {

    @IBOutlet weak var emptyCartStackView: UIStackView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalPriceView: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 70.0
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    var cartItems: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get products from User defaults
        cartItems = SharedUtility.poductList
        // hide tableview and bottom views if cart is empty
        tableView.isHidden = SharedUtility.poductList.isEmpty
        totalPriceView.isHidden = SharedUtility.poductList.isEmpty
        // Do any additional setup after loading the view.
        calculateTotalPrice()
    }
    
    func addProductToCart(_ product: ProductModel) {
        cartItems.append(product)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.tableView.reloadData()
        }
    }
        
    @IBAction func checkOut(_ sender: UIButton) {
        self.showHUD()
        SharedUtility.poductList = []
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.dismissHUD()
            let orderConfirmationVC = self.storyboard?.instantiateViewController(identifier: "OrderConfirmationVC") as! OrderConfirmationVC
            orderConfirmationVC.products = self.cartItems
            self.navigationController?.pushViewController(orderConfirmationVC, animated: true)
        }
    }
}

private extension CartViewController {
    
    @objc func deleteCartItem(_ sender: UIButton) {
        self.showAlert(title: "Remove Product?", message: "Are you sure you want to remove this product?", options: "Yes", "No") { [weak self] (index) in
            guard let self = self else { return }
            if index == 0 {
                self.cartItems.remove(at: sender.tag)
                self.tableView.reloadData()
                SharedUtility.poductList = self.cartItems
            }
        }
    }
    
    // increase item quantity in cart
    @objc func increaseQuantity(_ sender: UIButton) {
        // check if cart item quantity is less than 8 else show alert for max quantity
        guard cartItems[sender.tag].quantity < 8 else {
            self.showAlert(title: "Alert!", message: "Maximum allowed quantity is 8.")
            return
        }
        cartItems[sender.tag].quantity += 1
        tableView.reloadData()
        calculateTotalPrice()
    }
    
    // decrese item quantity in cart
    @objc func deccreaseQuantity(_ sender: UIButton) {
        guard cartItems[sender.tag].quantity > 1 else { return }
        cartItems[sender.tag].quantity -= 1
        tableView.reloadData()
        calculateTotalPrice()
    }
    
    // Calculate all the products price accroding to their quantity
    func calculateTotalPrice() {
        let totalPrice = cartItems.reduce(0) { (result, item) -> Double  in
            var sum = result
            if let price = item.price {
                sum += price * Double(item.quantity)
            }
            return sum
        }
        totalPriceLabel.text = totalPrice.convertToSelectedCurrencyStringFormat()
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartCell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        cartCell.setUpCartCell(cartItems[indexPath.row])
        cartCell.deleteButton.tag = indexPath.row
        cartCell.increaseProductButton.tag = indexPath.row
        cartCell.decreaseProductButton.tag = indexPath.row
        cartCell.deleteButton.addTarget(self, action: #selector(deleteCartItem(_:)), for: .touchUpInside)
        cartCell.increaseProductButton.addTarget(self, action: #selector(increaseQuantity(_:)), for: .touchUpInside)
        cartCell.decreaseProductButton.addTarget(self, action: #selector(deccreaseQuantity(_:)), for: .touchUpInside)
        return cartCell
    }
}

extension CartViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
