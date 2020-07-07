
import Foundation

protocol CharactersListPresenter {
    func setView(view: CharactersListViewController)
    func getCharacters(completion: @escaping() -> ())
    func numberOfCharacters() -> Int
    func characterNameForRow(row: Int) -> String
    func characterImagePathForRow(row: Int) -> URL?
    func isFavouriteCharacter(row: Int) -> Bool
    func didSelectCharacter(characterId: Int)
    func addCharacterToFavourite(characterIndex: Int)
    func filterFavourites()
}

class CharactersListPresenterDefault: CharactersListPresenter {
    
    private let charactersInteractor: CharactersInteractor
    private var userdefaults = UserDefaults.standard
    private var favouriteCharacters: [Int]
    private var characters = [Character]()
    private var showingCharacters = [Character]()
    private weak var view: CharactersListViewController?
    private var showFavourites = false {
        didSet {
            if showFavourites {
                showingCharacters = characters.filter { favouriteCharacters.contains($0.id) }
            } else {
                showingCharacters = characters
            }
        }
    }
    
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
            self.showingCharacters = characters
            completion()
        }
    }
    
    func numberOfCharacters() -> Int {
        return showingCharacters.count
    }
    
    func characterNameForRow(row: Int) -> String {
        return showingCharacters[row].name
    }
    
    func characterImagePathForRow(row: Int) -> URL? {
        return showingCharacters[row].imageURLPath
    }
    
    func isFavouriteCharacter(row: Int) -> Bool {
        for favourite in favouriteCharacters {
            print(favourite)
        }
        
        return favouriteCharacters.contains(showingCharacters[row].id)
    }
    
    func didSelectCharacter(characterId: Int) {
        view?.navigateToCharacterDetail(characterId: showingCharacters[characterId].id)
    }
    
    func addCharacterToFavourite(characterIndex: Int) {
        if favouriteCharacters.contains(characters[characterIndex].id) {
            favouriteCharacters = favouriteCharacters.filter { $0 != characters[characterIndex].id }
        } else {
            favouriteCharacters.append(characters[characterIndex].id)
        }
        
        userdefaults.set(favouriteCharacters, forKey: "FavouriteCharacters")
    }
    
    func filterFavourites() {
        showFavourites = !showFavourites
    }
}
