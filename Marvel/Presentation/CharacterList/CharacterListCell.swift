
import UIKit

protocol CharacterListCellDelegate: class {
    func didTapAddFavorite(cell: CharacterListCell)
}

class CharacterListCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .white
            nameLabel.backgroundColor = .black
        }
    }
    @IBOutlet weak var favouriteButton: UIButton!
    
    var isFavourite: Bool = false {
        didSet {
            favouriteIcon(isFavourite: isFavourite)
        }
    }
    
    weak var delegate: CharacterListCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        characterImageView.image = nil
        nameLabel.text = ""
        favouriteButton.setImage(nil, for: .normal)
    }
    
    private func favouriteIcon(isFavourite: Bool) {
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
    
    @IBAction func didTapAddFavourite(_ sender: Any) {
        isFavourite = !isFavourite
        delegate?.didTapAddFavorite(cell: self)
    }
}
