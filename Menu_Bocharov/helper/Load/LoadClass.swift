

import Foundation
import UIKit
import Alamofire
import AlamofireImage


class LoadModel: NSObject {
    
    static var shared = LoadModel()
    
    func loadAddress(completion: @escaping (DataAddress) -> Void){
        Loader().fetch(structData: DataAddress.self, url: url_api+"\(id)"+EnumRequest.address.rawValue, httpMethod: HttpMethod.get, parameters: nil, completion: { (address) in
            DispatchQueue.main.async {
                            completion(address)
                        }

                        },
                   completionError: {
                       (errorReq) in
                       print("errorReq: \(errorReq)")

                   })
    }
    
    func loadShop(completion: @escaping (DataShop) -> Void){
        Loader().fetch(structData: DataShop.self, url: url_api+"\(id)"+EnumRequest.shop.rawValue, httpMethod: HttpMethod.get, parameters: nil, completion: { (shop) in
            DispatchQueue.main.async {
                            completion(shop)
                        }
                print("data: \(shop)")
                    },
                           completionError: {
                               (errorReq) in
                               print("errorReq: \(errorReq)")

                    })
    }
    
    func loadCategory(id_shop: String, completion: @escaping (DataCategory) -> Void){
        print("id_shop: \(id_shop)")
        Loader().fetch(structData: DataCategory.self, url: url_api+"\(id)"+"/shop/"+id_shop+EnumRequest.category.rawValue, httpMethod: HttpMethod.get, parameters: nil, completion: { (category) in
                DispatchQueue.main.async {
                            completion(category)
                        }
                    },
                               completionError: {
                                   (errorReq) in
                                   print("errorReq: \(errorReq)")

                               })
      
    }
    func loadSubCategory(id_shop: String,id_cat:String, completion: @escaping (DataSubCategory) -> Void){
    Loader().fetch(structData: DataSubCategory.self, url: "http://85.119.145.2/api/user/\(id)/shop/\(id_shop)/products/\(id_cat)", httpMethod: HttpMethod.get, parameters: nil, completion: { (subcategory) in
            DispatchQueue.main.async {
                    completion(subcategory)
                }
                print("data: \(subcategory)")
                    },
                           completionError: {
                               (errorReq) in
                               print("errorReq: \(errorReq)")

                           })
    }
    
    func loadItems(id_shop: String, id_cat:String, id_subcat:String, completion: @escaping (DataItem) -> Void){
    Loader().fetch(structData: DataItem.self, url: "http://85.119.145.2/api/user/\(id)/shop/\(id_shop)/products/\(id_subcat)", httpMethod: HttpMethod.get, parameters: nil, completion: { (item) in
            DispatchQueue.main.async {
                    completion(item)
                }
                print("data: \(item)")
                    },
                           completionError: {
                               (errorReq) in
                               print("errorReq: \(errorReq)")

                           })
    }
    
    func loadProduct(id_shop: String, id_cat:String, id_subcat:String,completion: @escaping ([Product]) -> Void) {
            AF.request("http://85.119.145.2/api/user/\(id)/shop/\(id_shop)/products/\(id_subcat)").responseJSON{
                response in
                switch response.result {
                            case .success(let value):
                                if let json = value as? NSDictionary {
//                                    print("datattttt \(json["data"])")
                                    if let data = json["data"] as? NSArray {
                                        // print(json["data"] as? NSDictionary)
                                        print("datattttt \(data)")
                                        var subcategories: [Product]=[]
                                        for (product) in data where product is NSDictionary{
                                            //                                    print("data1: \(data)")
                                            if  let subcategory = Product(subdata: product as! NSDictionary ){
                                           subcategories.append(subcategory)
    //                                    print(subcategory)
                                        print("subcategory \(subcategory.name)")
                                           }
                                       
                                        }
                                        completion(subcategories)
                                    }

                                   
                   }
                                
                            case .failure(let error):
                                print(error)
                            }
            }
    }
    
    func loadOneProduct(id_shop: String, id_product:String, completion: @escaping (OneProductData) -> Void){
    Loader().fetch(structData: OneProductData.self, url: "http://85.119.145.2/api/user/\(id)/shop/\(id_shop)/product/\(id_product)", httpMethod: HttpMethod.get, parameters: nil, completion: { (item) in
            DispatchQueue.main.async {
                    completion(item)
                }
                print("data: \(item)")
                    },
                           completionError: {
                               (errorReq) in
                               print("errorReq: \(errorReq)")

                           })
    }
    
    
    
    
    func loadCredit(completion: @escaping (DataCreditModel) -> Void){
    Loader().fetch(structData: DataCreditModel.self, url: "http://85.119.145.2/api/user/\(id)/credit", httpMethod: HttpMethod.get, parameters: nil, completion: { (item) in
            DispatchQueue.main.async {
                    completion(item)
                }
                print("data: \(item)")
                    },
                           completionError: {
                               (errorReq) in
                               print("errorReq: \(errorReq)")

                           })
    }
    
    func loadDetailShop(id_shop: String, completion: @escaping (DataDetailShop) -> Void){
    Loader().fetch(structData: DataDetailShop.self, url: "http://85.119.145.2/api/user/\(id)/shop/\(id_shop)", httpMethod: HttpMethod.get, parameters: nil, completion: { (item) in
            DispatchQueue.main.async {
                    completion(item)
                }
                print("data: \(item)")
                    },
                           completionError: {
                               (errorReq) in
                               print("errorReq: \(errorReq)")

                           })
    }
    func sendBusket(completion: @escaping (AnswerBasketData) -> Void,completionError: ((ErrorModel) -> Void)? = nil){
        let preparam = ["banknote": myBasket.comment.banknote] as [String: Any]
        
        
        var tempDict1 = NSMutableDictionary()
        var tempDict2 = NSMutableDictionary()

        tempDict1.setValue(myBasket.comment.banknote, forKey : "banknote")
//        let myComment1 = try? JSONSerialization.data(withJSONObject: preparam)
        
        let param = ["to": myBasket.to,                                                              "payment_card": myBasket.payment_card,
                     "payment_method": myBasket.payment_method,
                     "promo_codes": myBasket.promo_codes,
                     "credit": myBasket.credit,
//        "comment": "{"+"\"banknote\":"+"\(myComment.banknote)}",
                     "comment": preparam,
                     "products": myBasket.products] as [String : Any]
        
        print("parameters: \(param)")
    
        
        Loader().fetch(structData: AnswerBasketData.self, url: "http://85.119.145.2/api/user/\(id)/order/food", httpMethod: HttpMethod.post, parameters: param, completion: { (item) in
                    DispatchQueue.main.async {
                            completion(item)
                        }
                        print("product data: \(item)")

                            },
                                   completionError: {
                                       (errorReq) in
                                       print("errorReq: \(errorReq)")

                                   })
    }
    
    func loadImage(icon: String, completion: @escaping (UIImage) -> Void){
    AF.request("http://85.119.145.2/"+icon).responseImage { response in
        debugPrint(response)
        print(response.request)
        print(response.response)
        debugPrint(response.result)

        if case .success(let image) = response.result {
            print("image downloaded: \(image)")
//            DispatchQueue.main.async {
                    completion(image)
//                }
//            cell.image.image = image
        }
    }
    }

}

