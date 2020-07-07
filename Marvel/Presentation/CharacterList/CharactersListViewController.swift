
import UIKit

class CharactersListViewController: UIViewController, Spinnable, Alertable {
    private var presenter: CharactersListPresenter = CharactersListPresenterDefault()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setView(view: self)
        
        presenter.getCharacters {
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favourites", style: .plain, target: self, action: #selector(filterFavourites))
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func filterFavourites() {
        presenter.filteringFavourites = !presenter.filteringFavourites
        reloadTable()
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func navigateToCharacterDetail(characterId: Int) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MarvelView", bundle: nil)
        guard let characterDetailViewController = storyBoard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController else {
            return
        }
        characterDetailViewController.characterId = characterId
        present(characterDetailViewController, animated: true)
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCharacters()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterListCell", for: indexPath) as! CharacterListCell
        cell.delegate = self
        cell.nameLabel.text = presenter.characterNameForRow(row: row)
        cell.isFavourite = presenter.setFavouriteCharacter(row: row)
        
        guard let url = presenter.characterImagePathForRow(row: row) else {
            return cell
        }
        
        cell.characterImageView.load(url: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectCharacter(characterId: indexPath.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension CharactersListViewController: CharacterListCellDelegate {
    func didTapAddFavorite(cell: CharacterListCell) {
        guard let favouriteIndexpath = tableView.indexPath(for: cell) else {
            return
        }
        
        presenter.addCharacterToFavourite(characterIndex: favouriteIndexpath.row)
    }
}
