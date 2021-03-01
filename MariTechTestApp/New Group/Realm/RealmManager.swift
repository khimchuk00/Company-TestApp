import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    func savePhoto(object: PhotoObject) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add([object],update: .all)
            }
        } catch {
            print("Erorr")
        }
    }
    
    func getPhoto(for name: String) -> PhotoObject? {
            getObjects().first { $0.name == name }
    }
    
    func getObjects() -> [PhotoObject] {
        do {
            let realm = try Realm()
            return Array(realm.objects(PhotoObject.self))
        } catch {
           return []
        }
    }
}
