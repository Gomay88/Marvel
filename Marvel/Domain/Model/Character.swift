
import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics: Work
    let series: Work
    let stories: Work
    let events: Work
    let urls: [Url]
    
    var imageURLPath: URL? {
        guard let url = URL(string: thumbnail.path + "." + thumbnail.thumbnailExtension) else {
            return nil
        }
        
        return url
    }

    struct Thumbnail: Decodable {
        let path: String
        let thumbnailExtension: String

        enum CodingKeys: String, CodingKey {
            case path
            case thumbnailExtension = "extension"
        }
    }
    
    struct Work: Decodable {
        let available: Int
        let collectionURI: String
        let items: [WorkItem]
        let returned: Int
    }
    
    struct WorkItem: Codable {
        let resourceURI: String
        let name: String
        let type: String?
    }
    
    struct Url: Decodable {
        let url: String
        let type: String
    }
}
