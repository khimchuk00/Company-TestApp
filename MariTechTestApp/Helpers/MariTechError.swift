import Foundation

struct MariTechError: Error, LocalizedError {
    
    var message: String
    var errorDescription: String? {
        message
    }
}
