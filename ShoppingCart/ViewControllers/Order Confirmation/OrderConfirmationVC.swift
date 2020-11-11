//
//  OrderConfirmationVC.swift
//  ShoppingCart
//
//  Created by toq33r on 11/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import UIKit

class OrderConfirmationVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // get Home Listing view controller from navigation array and Pop the view controller
    @IBAction func goBackToHome(_ sender: UIButton) {
        if let controllers = self.navigationController?.viewControllers {
            controllers.forEach { (viewController) in
                if viewController.isKind(of: ListViewController.self) {
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
            }
        }
    }
}
