import UIKit

class ImageViewModel {
    
    @BindingValue var image: UIImage?
    @OptionalBindingValue var error: Error?
    
    func loadImage(for name: String) {
        ImageFetchServise.shared.fetchImage(query: name) { photoObject in
            self.image = photoObject.image
        } failure: { error in
            self.error = error
        }
    }
}
