import Foundation
import UIKit

// View onde é exibido os detalhes dos filmes.
class DetailsViewController: UIViewController {
    
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
    
    var myImage: UIImage?

    var movieVM: MovieViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
          setupView()
        
    }
    
    func setupView() {
        
        genreView.layer.cornerRadius = 10
        rateView.layer.cornerRadius = 10
        titleLabel.text = movieVM?.title
        subtitleLabel.text = movieVM?.originalTitle
        overviewLabel.text = movieVM?.overview
        
        let newDate = MovieViewModel.formattedDateFromString(dateString: movieVM?.releaseDate ?? "")
        dateLabel.text = "Data de lançamento: \(newDate!)"
        rateLabel.text = "⭐️ \(movieVM!.voteAverage)"
        imageMovieDetails.image = myImage
    }
    
    // Método para compartilhamento do link e imagem.
    @objc private func presentShareSheet(image: UIImage){
        
        // A principio não sabia quais dados compartilhar, porém ao ver o URL do site percebi que as páginas dos filmes recebiam o mesmo ID recebido pela API.
        guard let url = URL(string: "https://www.themoviedb.org/movie/\(movieVM!.id)") else {return}
        
            let shareSheetVC = UIActivityViewController (activityItems: [
                image,
            url
            ], applicationActivities: nil
            )
            present(shareSheetVC, animated: true)
    }

    // Método que identificará o toque no botão de compartilhamento.
    @IBAction func shareAction(_ sender: Any) {
        presentShareSheet(image: myImage!)
    }
}
