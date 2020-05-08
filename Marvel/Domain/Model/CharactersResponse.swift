
import Foundation

struct CharactersResponse: Decodable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let etag: String
    let data: CharactersData
    
    struct CharactersData: Decodable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [Character]
    }
}
