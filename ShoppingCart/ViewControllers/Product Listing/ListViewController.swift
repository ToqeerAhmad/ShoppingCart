//
//  ViewController.swift
//  ShoppingCart
//
//  Created by toq33r on 09/11/2020.
//  Copyright © 2020 Testing. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cartCountLabel: UILabel!

    // Varibales
    var productsList: [ProductModel] =  []
    private var cellIdentifier = "ProductCollectionViewCell"
    private var shouldShowSkeleton: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpSkeletonView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide cart count of cart array is empty
        cartCountLabel.isHidden = SharedUtility.poductList.isEmpty
        if !SharedUtility.poductList.isEmpty {
            cartCountLabel.text = "\(SharedUtility.poductList.count)"
        }
        
    }
    
    // Push to Cart from Home
    @IBAction func showCart(_ sender: UIButton) {
        let cartViewController = self.storyboard?.instantiateViewController(identifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(cartViewController, animated: true)
    }
}

private extension ListViewController {
    
    func setUpSkeletonView() {
        // Add dummy data to show skeleton
        for _ in 0...9 {
            productsList.append(ProductModel())
        }
        collectionView.setNeedsLayout()
        // Api call for Products
        fetchProfuctsList()
    }
    
    func fetchProfuctsList() {
        ProductsAPiManager.shared.fetchProductsList(success: { [weak self] (products) in
            guard let self = self else {return}
            self.shouldShowSkeleton = false
            self.productsList = products
            self.collectionView.reloadData()
        }) { (error) in
            print(error)
        }
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shouldShowSkeleton ? 10 : productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProductCollectionViewCell
        productCell.displaySkeleton(shouldShowSkeleton)
        productCell.setUpProductCell(productsList[indexPath.row])
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard productsList[indexPath.row].productID != 0 else { return }
        let cartViewController = self.storyboard?.instantiateViewController(identifier: "ProductDetailViewController") as! ProductDetailViewController
        cartViewController.productDetail = productsList[indexPath.row]
        self.navigationController?.pushViewController(cartViewController, animated: true)
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(collectionView.bounds.width / 2)-10, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}
