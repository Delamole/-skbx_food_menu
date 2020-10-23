//
//  OneProductViewController.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 28.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

protocol UpdateBusketDelegate {
    func isBusketEmpty()
}

class OneProductViewController: UIViewController {

    @IBOutlet weak var optionConstr: NSLayoutConstraint!
    @IBOutlet weak var upConstr: NSLayoutConstraint!
    @IBOutlet weak var commonPriceLabel: UILabel!
    @IBOutlet weak var tobasketButton: UIView!
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var hitImage: UIImageView!
    @IBOutlet weak var countryProduct: UILabel!
    @IBOutlet weak var producingProduct: UILabel!
    @IBOutlet weak var compositionProduct: UILabel!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    

    
    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var saleLabel: UILabel!
    var id_product = 0
    var id_shop = 0
    var product: OneProduct? = nil
    var count = 1
    
    var delegate: UpdateBusketDelegate?
    
    @IBAction func toOrder(_ sender: Any) {
    }
    @IBOutlet weak var countLabel: UILabel!
    @IBAction func minusButton(_ sender: Any) {
        count-=1
        countLabel.text = "\(count)"
        let pr = product?.price ?? 0
        commonPriceLabel.text = ("\(pr*count) руб")
    }
    
    @IBAction func plusButton(_ sender: Any) {
        count+=1
        countLabel.text = "\(count)"
        let pr = product?.price ?? 0
        commonPriceLabel.text = ("\(pr*count) руб")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        upConstr.constant = 0.1 * view.bounds.height
        optionConstr.constant = imageProduct.bounds.height
        
        mainView.layer.cornerRadius = 15
        tobasketButton.layer.cornerRadius = 15
        
        tobasketButton.backgroundColor = activButtonColor
        countLabel.text = "\(count)"
        

        LoadModel.shared.loadOneProduct(id_shop: "\(id_shop)", id_product: "\(id_product)") { (data) in self.product = data.data
            
            print("oneproduct: \(data)")
            self.nameProduct.text = self.product?.name
            self.compositionProduct.text = self.product?.composition
            self.producingProduct.text = self.product?.producing
            self.countryProduct.text = self.product?.producing
            
            LoadModel.shared.loadImage(icon: self.product!.icon) { (data) in
                self.imageProduct.image = data
            }
            
            self.commonPriceLabel.text = ("\(self.product?.price ?? 0) руб")
            
            if self.product?.hit != 0{
                self.optionView.isHidden = false
                self.hitImage.image = UIImage(named: "hit")
            }
            if self.product?.sale != 0{
                self.optionView.isHidden = false
                self.saleLabel.isHidden = false
                self.saleLabel.text = "\(self.product?.sale ?? 0)%"
                self.hitImage.image = UIImage(named: "sale")
                
            }
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func sendToBasket(_ sender: Any) {
        
        for _ in 1...count{
            myBasket.products.append(id_product)
        }
        var item = TableProductBasket()
        item.count = count
        item.name = product!.name
        item.price = product!.price
        myBasket.prods.append(item)
        
        
        
        let index1 = commonPriceLabel.text!.index(commonPriceLabel.text!.endIndex, offsetBy: -4)
        let substring1 = commonPriceLabel.text!.substring(to: index1)
        
        myBasket.price = myBasket.price + (substring1.convertStringToInt())
        dismiss(animated: true, completion: nil)
        print(myBasket.price)
        print(myBasket.products)
        
        delegate?.isBusketEmpty()
    }
}
