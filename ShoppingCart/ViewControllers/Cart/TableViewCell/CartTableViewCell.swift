//
//  CartTableViewCell.swift
//  ShoppingCart
//
//  Created by toq33r on 10/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    // IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var increaseProductButton: UIButton!
    @IBOutlet weak var productCountLabel: UILabel!
    
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var decreaseProductButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCartCell(_ product: ProductModel) {
        productImageView.sd_setImage(with: URL(string: product.filename), placeholderImage: nil)
        productNameLabel.text = product.title
        productQuantityLabel.text = "\(product.quantity)"
        productCategoryLabel.text = product.category.capitalized
        // check price is not nil and calculate amount by multiplying price and quantity
        if let price = product.price {
            let calculatedPrice = Double(product.quantity) * price
            priceLabel.text = calculatedPrice.convertToSelectedCurrencyStringFormat()//"Price: \()"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
