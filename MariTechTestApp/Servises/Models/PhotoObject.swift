import UIKit
import RealmSwift

class PhotoObject: Object {
    @objc dynamic var name: String!
    @objc dynamic var photoData: Data!
    
    var image: UIImage? {
        UIImage(data: photoData)
    }
    
    override required init() {
        super.init()
    }
    
    init(name: String, photoData: Data) {
        self.name = name
        self.photoData = photoData
    }
    
    override class func primaryKey() -> String? {
        "name"
    }
}

