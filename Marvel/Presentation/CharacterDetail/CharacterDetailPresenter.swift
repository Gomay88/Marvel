
import Foundation

protocol CharacterDetailPresenter {
    func setView(view: CharacterDetailViewController)
    func getCharacterDetail(characterId: Int, completion: @escaping(_ character: Character) -> ())
    func downloadImage(completion: @escaping(_ imageData: Data) -> ())
}

class CharacterDetailPresenterDefault: CharacterDetailPresenter {
    
    private let characterDetailInteractor: CharacterDetailInteractor
    private var character: Character?
    private weak var view: CharacterDetailViewController?
    
    init() {
        characterDetailInteractor = CharacterDetailInteractorDefault()
    }
    
    func setView(view: CharacterDetailViewController) {
        self.view = view
    }
    
    func getCharacterDetail(characterId: Int, completion: @escaping(_ character: Character) -> ()) {
        view?.startSpinner()
        characterDetailInteractor.execute(characterId: characterId) { (character, error) in
            self.view?.endSpinner()
            guard let character = character else {
                self.view?.showError(error: error!)
                return
            }
            
            return completion(character)
        }
    }
    
    func downloadImage(completion: @escaping(_ imageData: Data) -> ()) {
        guard let path = character?.thumbnail.path else {
            return
        }
        
        guard let imageExtension = character?.thumbnail.thumbnailExtension else {
            return
        }
        
        guard let url = URL(string: path + "." + imageExtension) else {
            return
        }
        
        getData(from: url) { data, response, error in
            guard let data = data else {
                return
            }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                completion(data)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
