 import Foundation

class ImageFetchServise {
    
    static let shared = ImageFetchServise()
    
    private init() {}
    
    func fetchImage(query: String, successes: @escaping (PhotoObject) -> Void, failure: @escaping (Error) -> Void) {
        if let photo = RealmManager.shared.getPhoto(for: query) {
            successes(photo)
        } else {
            NetworkManager.shared.searchImage(query: query) { photoObject in
                DispatchQueue.main.async {
                    RealmManager.shared.savePhoto(object: photoObject)
                }
                successes(photoObject)
            } failure: { error in
                failure(error)
            }
        }
    }
}
