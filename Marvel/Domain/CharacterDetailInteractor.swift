
import Foundation

protocol CharacterDetailInteractor {
    func execute(characterId: Int, completion: @escaping (_ characters: Character?, _ error: Error?) -> ())
}

class CharacterDetailInteractorDefault: CharacterDetailInteractor {
    
    private var charactersRepository: CharactersRepository = CharactersRepositoryDefault()
    
    init() {
    }
    
    func execute(characterId: Int, completion: @escaping (_ characters: Character?, _ error: Error?) -> ()) {
        charactersRepository.getCharacterInfo(characterId: characterId) { (charactersResponse, error) in
            completion(charactersResponse?.data.results.first, error)
        }
    }
}
