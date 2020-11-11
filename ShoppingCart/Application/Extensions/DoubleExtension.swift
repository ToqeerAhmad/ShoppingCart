//
//  DoubleExtension.swift
//  ShoppingCart
//
//  Created by toq33r on 10/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import UIKit

extension Double {
    
    func convertToSelectedCurrencyStringFormat() -> String {
        return "AED" + String(format: " %.2f", self.roundTo(places: 2))
    }
    
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func convertToString(decimalPlaces: Int) -> String {
        let number = self.roundTo(places: decimalPlaces)
        return String(format: " %.\(decimalPlaces)f", number)
    }
}
