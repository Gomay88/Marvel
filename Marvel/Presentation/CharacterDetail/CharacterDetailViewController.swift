
import UIKit

class CharacterDetailViewController: UIViewController, Spinnable {
    private let presenter: CharacterDetailPresenter = CharacterDetailPresenterDefault()
    var characterId: Int?
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var comicsAvailable: UILabel!
    @IBOutlet weak var seriesAvailable: UILabel!
    @IBOutlet weak var storiesAvailable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.setCustomSpacing(10, after: characterImageView)
        
        presenter.setView(view: self)
        
        guard let characterId = characterId else {
            //TODO: Show alert
            return
        }
        
        presenter.getCharacterDetail(characterId: characterId) { (character) in
            DispatchQueue.main.async(execute: {
                let path = character.thumbnail.path
                let imageExtension = character.thumbnail.thumbnailExtension
                
                guard let url = URL(string: path + "." + imageExtension) else {
                    return
                }
                
                self.characterImageView.load(url: url)
                self.characterName.text = "Nombre: " + character.name
                self.comicsAvailable.text = "Comics: " + String(character.comics.available)
                self.seriesAvailable.text = "Series: " + String(character.series.available)
                self.storiesAvailable.text = "Stories: " + String(character.stories.available)
            })
        }
    }
}