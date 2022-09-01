import Foundation
import UIKit

// View onde é exibido os detalhes dos filmes.
class DetailsViewController: UIViewController {
    
    var moviesVC: MoviesListViewModel!
    
    
    @IBOutlet weak var imageMovieDetails: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var genreView: UIView!
    @IBOutlet weak var rateView: UIView!

    
    var date: String?
    var movieTitle: String?
    var movieSubtitle: String?
    var movieOverview: String?
    var imageKey: String?
    var voteAverage: Double?
    var id: Int?
    var genreString: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        genreView.layer.cornerRadius = 10
        rateView.layer.cornerRadius = 10
        
        if let genreString = genreString {
            genreLabel.text = genreString
        } else {genreLabel.text = "-"}
    
        titleLabel.text = movieTitle
        subtitleLabel.text = movieSubtitle
        overviewLabel.text = movieOverview
        let newDate = formattedDateFromString(dateString: date!)
        dateLabel.text = "Data de lançamento: \(newDate!)"
        rateLabel.text = "⭐️ \(voteAverage!)"
        imageMovieDetails.image = UIImage().posterPath_ToImage(imageKey: imageKey!)
    }
    
    // Método para compartilhamento do link e imagem.
    @objc private func presentShareSheet(image: UIImage){
        
        // A principio não sabia quais dados compartilhar, porém ao ver o URL do site percebi que as páginas dos filmes recebiam o mesmo ID recebido pela API.
        guard let url = URL(string: "https://www.themoviedb.org/movie/\(id!)") else {return}
        
            let shareSheetVC = UIActivityViewController (activityItems: [
                image,
            url
            ], applicationActivities: nil
            )
            present(shareSheetVC, animated: true)
    }

    // Método que identificará o toque no botão de compartilhamento.
    @IBAction func shareAction(_ sender: Any) {
        presentShareSheet(image: UIImage().posterPath_ToImage(imageKey: imageKey!))
    }
}
