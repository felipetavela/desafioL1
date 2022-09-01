import Foundation
import UIKit

struct Results: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    
    let id: Int?
    let imdbID: String?
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let genreIDs: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imdbID = "imdb_id"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genreIDs = "genre_ids"
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIImage {
func imageURL_ToUIImage (imageKey: String) -> UIImage {
    let urlImage = URL(string: "https://image.tmdb.org/t/p/w500/\(imageKey)")!
    
    let imageData: Data = try! Data(contentsOf: urlImage)
    
    return UIImage(data: imageData)!
}
}

