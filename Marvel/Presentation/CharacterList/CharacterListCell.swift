
import UIKit

class CharacterListCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .white
            nameLabel.backgroundColor = .black
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        characterImageView.image = nil
        nameLabel.text = ""
    }
    
}
