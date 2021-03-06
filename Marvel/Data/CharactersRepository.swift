
import Foundation
import CommonCrypto

protocol CharactersRepository {
    func getCharacters(completion: @escaping (_ characters: CharactersResponse?, _ error: Error?)->())
    func getCharacterInfo(characterId: Int, completion: @escaping (CharactersResponse?, Error?) -> ())
}

class CharactersRepositoryDefault: BaseRepository, CharactersRepository {
    func getCharacters(completion: @escaping (_ characters: CharactersResponse?, _ error: Error?)->()) {
        let dateFormatter = DateFormatter()
        let now = dateFormatter.string(from: Date())
        let md5ParamsHex = getHashForString(string: now)
        
        let request = RequestBuilder.marvel()
            .get()
            .parameter(["hash": md5ParamsHex, "ts": now, "apikey": Constants.publicKey])
            .path("characters")
            .builtHttpRequest()
        
        execute(request: request, responseType: CharactersResponse.self, completion: completion)
    }
    
    func getCharacterInfo(characterId: Int, completion: @escaping (CharactersResponse?, Error?) -> ()) {
        let dateFormatter = DateFormatter()
        let now = dateFormatter.string(from: Date())
        let md5ParamsHex = getHashForString(string: now)
        
        let request = RequestBuilder.marvel()
            .get()
            .parameter(["hash": md5ParamsHex, "ts": now, "apikey": Constants.publicKey])
            .path("characters/\(characterId)")
            .builtHttpRequest()
        
        execute(request: request, responseType: CharactersResponse.self, completion: completion)
    }
    
    func getHashForString(string: String) -> String {
        let md5Params = MD5(string: string + Constants.privateKey + Constants.publicKey)
        return md5Params.map { String(format: "%02hhx", $0) }.joined()
    }
    
    private func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
}
