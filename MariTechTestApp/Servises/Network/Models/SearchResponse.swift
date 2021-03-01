import Foundation

struct SearchResponse: Decodable {
    
    var photos: [Images]
    
    var bestResolutionImage: SearchPhotoObject? {
        guard photos.first?.images.isEmpty == false else {
            return nil
        }
        
        var result = photos[0].images[0]
        
        for photo in photos.first?.images ?? [] where photo.size > result.size {
            result = photo
        }
        
        return result
    }
}
