
import Foundation

protocol CharactersListPresenter {
    func setView(view: CharactersListViewController)
    func getCharacters(completion: @escaping() -> ())
    func numberOfCharacters() -> Int
    func characterNameForRow(row: Int) -> Character
    func didSelectCharacter(characterId: Int)
}

class CharactersListPresenterDefault: CharactersListPresenter {
    
    private let charactersInteractor: CharactersInteractor
    private var characters = [Character]()
    private weak var view: CharactersListViewController?
    
    init() {
        charactersInteractor = CharactersInteractorDefault()
    }
    
    func setView(view: CharactersListViewController) {
        self.view = view
    }
    
    func getCharacters(completion: @escaping() -> ()) {
        view?.startSpinner()
        charactersInteractor.execute { (characters, error) in
            self.view?.endSpinner()
            guard let characters = characters else {
                self.view?.showError(error: error!)
                return
            }
            
            self.characters = characters
            completion()
        }
    }
    
    func numberOfCharacters() -> Int {
        return characters.count
    }
    
    func characterNameForRow(row: Int) -> Character {
        return characters[row]
    }
    
    func didSelectCharacter(characterId: Int) {
        view?.navigateToCharacterDetail(characterId: characters[characterId].id)
    }
}
