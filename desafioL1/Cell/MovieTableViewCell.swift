import UIKit

// Classe contendo as views da TableViewCell.
class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
}
