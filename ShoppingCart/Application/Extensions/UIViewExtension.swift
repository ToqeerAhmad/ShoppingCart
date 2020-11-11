//
//  UIViewExtension.swift
//  ShoppingCart
//
//  Created by toq33r on 10/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
