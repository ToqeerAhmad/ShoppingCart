//
//  ProductCollectionViewCell.swift
//  ShoppingCart
//
//  Created by toq33r on 09/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import UIKit
import SDWebImage
import SkeletonView

class ProductCollectionViewCell: UICollectionViewCell {
    
    // IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpProductCell(_ product: ProductModel) {
        productImageView.sd_setImage(with: URL(string: product.filename), placeholderImage: nil)
        productNameLabel.text = product.title
        // Check if price is not nil
        if let price = product.price {
            productPriceLabel.text = price.convertToSelectedCurrencyStringFormat()
        }
    }
    
    // Show hide skeleton 
    func displaySkeleton(_ shouldShowSkeleton: Bool) {
        shouldShowSkeleton ? showSkeleton() : hideSkeleton()
    }
    
    func showSkeleton() {
        productImageView.showAnimatedGradientSkeleton()
        productNameLabel.isHidden = true
        productPriceLabel.isHidden = true
    }
    
    func hideSkeleton() {
        productImageView.hideSkeleton()
        productNameLabel.isHidden = false
        productPriceLabel.isHidden = false
    }
}

