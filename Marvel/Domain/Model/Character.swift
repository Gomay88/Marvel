
import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics: Comic
    let series: Comic
    let stories: Comic
    let events: Comic
    let urls: [Url]

    struct Thumbnail: Decodable {
        let path: String
        let ext: String
    }
    
    struct Comic: Decodable {
        let available: Int
        let collectionURI: String
        let items: [Url]
        let returned: Int
    }
    
    struct Url: Decodable {
        let type: String
        let url: String
    }
}
