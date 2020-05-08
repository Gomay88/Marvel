
import Foundation

protocol CharactersInteractor {
    func execute(completion: @escaping (_ characters: [Character]?, _ error: Error?) -> ())
}

class CharactersInteractorDefault: CharactersInteractor {
    
    private var charactersRepository: CharactersRepository = CharactersRepositoryDefault()
    
    init() {
    }
    
    func execute(completion: @escaping (_ characters: [Character]?, _ error: Error?) -> ()) {
        charactersRepository.getCharacters { (charactersResponse, error) in
            completion(charactersResponse?.data.results, error)
        }
    }
}
