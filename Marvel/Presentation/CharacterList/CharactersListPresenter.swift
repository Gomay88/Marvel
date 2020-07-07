
import Foundation

protocol CharactersListPresenter {
    var filteringFavourites: Bool { get set }
    
    func setView(view: CharactersListViewController)
    func getCharacters(completion: @escaping() -> ())
    func numberOfCharacters() -> Int
    func characterNameForRow(row: Int) -> String
    func characterImagePathForRow(row: Int) -> URL?
    func setFavouriteCharacter(row: Int) -> Bool
    func didSelectCharacter(characterId: Int)
    func addCharacterToFavourite(characterIndex: Int)
}

class CharactersListPresenterDefault: CharactersListPresenter {
    
    private let charactersInteractor: CharactersInteractor
    private var userdefaults = UserDefaults.standard
    private var favouriteCharacters: [Int]
    private var characters: [Character] = [Character]()
    
    private var filteredCharacters: [Character] {
        get {
            if filteringFavourites {
                return self.characters.filter { favouriteCharacters.contains($0.id) }
            } else {
                return self.characters
            }
        }
        
        set {
            self.characters = newValue
        }
    }
    
    private weak var view: CharactersListViewController?
    var filteringFavourites: Bool = false
    
    init() {
        charactersInteractor = CharactersInteractorDefault()
        favouriteCharacters = userdefaults.array(forKey: "FavouriteCharacters") as? [Int] ?? []
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
        return filteredCharacters.count
    }
    
    func characterNameForRow(row: Int) -> String {
        return filteredCharacters[row].name
    }
    
    func characterImagePathForRow(row: Int) -> URL? {
        return filteredCharacters[row].imageURLPath
    }
    
    func setFavouriteCharacter(row: Int) -> Bool {
        return favouriteCharacters.contains(filteredCharacters[row].id)
    }
    
    func didSelectCharacter(characterId: Int) {
        view?.navigateToCharacterDetail(characterId: filteredCharacters[characterId].id)
    }
    
    func addCharacterToFavourite(characterIndex: Int) {
        if favouriteCharacters.contains(filteredCharacters[characterIndex].id) {
            favouriteCharacters = favouriteCharacters.filter { $0 != filteredCharacters[characterIndex].id }
        } else {
            favouriteCharacters.append(filteredCharacters[characterIndex].id)
        }
        
        userdefaults.set(favouriteCharacters, forKey: "FavouriteCharacters")
        if filteringFavourites {
            view?.reloadTable()
        }
    }
}
