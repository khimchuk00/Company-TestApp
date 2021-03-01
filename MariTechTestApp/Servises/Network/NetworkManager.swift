import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () {
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
    }
    
    func searchImage(query: String, successes: @escaping (PhotoObject) -> Void, failure: @escaping (Error) -> Void) {
        var components = URLComponents(string: "https://api.500px.com/v1/photos/search")
        components?.queryItems = [
            URLQueryItem(name: "terms", value: query)
        ]
        var request = URLRequest(url: components!.url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response , error in
            guard let data = data,
                  let decodedResponse = try? JSONDecoder().decode(SearchResponse.self, from: data),
                  let bestImg = decodedResponse.bestResolutionImage,
                  let url = URL(string: bestImg.httpsUrl),
                  let imgData = try? Data(contentsOf: url) else {
                failure(MariTechError(message: "Error with response"))
                return
            }
            
            let obj = PhotoObject(name: query, photoData: imgData)
            successes(obj)
        }
        task.resume()
    }
}

