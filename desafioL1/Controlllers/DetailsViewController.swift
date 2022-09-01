import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var moviesVC: MoviesListViewModel!
    
    @IBOutlet weak var imageMovieDetails: UIImageView!
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var subtituloLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
   
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var genreView: UIView!
    @IBOutlet weak var rateView: UIView!
    
    var date: String?
    var movieTitle: String?
    var movieSubtitulo: String?
    var movieSinopse: String?
    var imageKey: String?
    var voteAverage: Double?
    var id: Int?
    var genreString: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genreView.layer.cornerRadius = 10
        rateView.layer.cornerRadius = 10
        
        genreLabel.text = genreString
        tituloLabel.text = movieTitle
        subtituloLabel.text = movieSubtitulo
        sinopseLabel.text = movieSinopse
        dateLabel.text = date
        voteLabel.text = "⭐️ \(voteAverage!)"

        imageMovieDetails.image = UIImage().imageURL_ToUIImage(imageKey: imageKey!)
    }
    
    
    @objc private func presentShareSheet(image: UIImage){
        
        guard let url = URL(string: "https://www.themoviedb.org/movie/\(id!)") else {return}
        
            let shareSheetVC = UIActivityViewController (activityItems: [
                image,
            url
            ], applicationActivities: nil
            )
            present(shareSheetVC, animated: true)
    }

    @IBAction func shareAction(_ sender: Any) {
        
        presentShareSheet(image: UIImage().imageURL_ToUIImage(imageKey: imageKey!))
    }
}
