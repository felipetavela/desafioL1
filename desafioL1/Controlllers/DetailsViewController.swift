import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var moviesVC: MoviesListViewModel!
    
    @IBOutlet weak var imageMovieDetails: UIImageView!
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var subtituloLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var date: String?
    var movieTitle: String?
    var movieSubtitulo: String?
    var movieSinopse: String?
    var imageKey: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tituloLabel.text = movieTitle
        subtituloLabel.text = movieSubtitulo
        sinopseLabel.text = movieSinopse
        dateLabel.text = date
        
        
        
        imageMovieDetails.image = imageURL_ToUIImage(imageKey: imageKey!)
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        
        let image = view.asImage()
        
        let imageToShare = [ image ]
               let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
               activityViewController.popoverPresentationController?.sourceView = self.view
        
               activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
             
               self.present(activityViewController, animated: true, completion: nil)
           }
    }
