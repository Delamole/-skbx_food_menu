import Foundation

struct DataAddress: Decodable {
    var data: [Adres]
}

struct Adres: Decodable {
    var id: Int
    var name: String
    var address: String
//    var comment_driver: String
//    var comment_courier: String
//    var flat: Int
//    var intercom: Int
//    var entrance: Int
//    var floor: Int
//    var destination: Bool
}



