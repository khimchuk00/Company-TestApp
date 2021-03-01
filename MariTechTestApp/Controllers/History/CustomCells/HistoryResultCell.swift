import UIKit

class HistoryResultCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(photoObject: PhotoObject) {
        cellImageView.image = photoObject.image
        nameLabel.text = photoObject.name
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        cellImageView.image = nil
    }
}
