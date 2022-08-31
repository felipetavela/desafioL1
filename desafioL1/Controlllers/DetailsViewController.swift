import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var moviesVC: MoviesListViewModel!
    
    @IBOutlet weak var imageMovieDetails: UIImageView!
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var subtituloLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
   
    @IBOutlet weak var shareButton: UIButton!
    
    var date: String?
    var movieTitle: String?
    var movieSubtitulo: String?
    var movieSinopse: String?
    var imageKey: String?
    var id: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tituloLabel.text = movieTitle
        subtituloLabel.text = movieSubtitulo
        sinopseLabel.text = movieSinopse
        dateLabel.text = date
        shareButton.layer.cornerRadius = 15

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
