import Foundation

struct SearchPhotoObject: Decodable {
    
    var size: Int
    var httpsUrl: String
    
    enum CodingKeys: String, CodingKey {
        case size
        case httpsUrl = "https_url"
    }
}
