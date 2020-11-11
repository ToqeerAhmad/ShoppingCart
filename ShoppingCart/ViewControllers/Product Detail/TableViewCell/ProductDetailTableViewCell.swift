//
//  ProductDetailTableViewCell.swift
//  ShoppingCart
//
//  Created by toq33r on 11/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {

    // IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Setup product detail cell
    func setUpDetailCell(_ product: ProductModel) {
        productImageView.sd_setImage(with: URL(string: product.filename), placeholderImage: nil)
        productNameLabel.text = product.title
        productDescriptionLabel.text = product.productDescription
        productCategoryLabel.text = product.category.capitalized
        if let price = product.price {
            priceLabel.text = price.convertToSelectedCurrencyStringFormat()//"Price: \()"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
