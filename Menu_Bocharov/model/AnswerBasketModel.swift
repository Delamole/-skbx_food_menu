

import Foundation

struct AnswerBasketData: Decodable {
    var data: AnswerBasket
}

struct AnswerBasket: Decodable {
    var id: Int
    var user_id: Int
//    var from: String
    var to: String
    var credit: Int
    var distance: Int
    var price: Int
    var discount: Int
    var for_payment: Int
    var type: String
    var status: String
    var comment: CommentData

//    var tariff: Tarif
//    var promoCodes: [Promos]
//    var availablePromoCodes: [Promos]
    var created_at: Int
    var updated_at: Int
    var courier: [CourierData]
    var payment: PaymentData
    var products: [OneProduct]
    
}

struct CommentData: Decodable {
    var banknote: Int
    
}
//var myComment = CommentData(banknote: 5000)


struct CourierData: Decodable {
    var id: Int
    var created_at: String
    var updated_at: String
    var name: String
    var phone: String
    var pivot: PivotData
}

struct PivotData: Decodable {
    var order_id: Int
    var provide_id: Int
}

struct PaymentData: Decodable {
    var id: Int
    var created_at: String
    var updated_at: String
//    var deleted_at: String
    var order_id: Int
//    var payment_card_id: Int
    var paid: Int
    var method: String
    var status: String
}

struct Tarif: Decodable {
    var id: Int
    var name: String
    var cars: String
    var description: String
    var icon: String
}


