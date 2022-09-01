import Foundation
import UIKit

// Struct Results contendo a constate results(array da classe Movie), conforme o JSON.
struct Results: Codable {
    let results: [Movie]
}

// Struct Movie contendo todas as constantes necessárias e seus especificos CodignKeys(Necessário para traduzir o JSON)
struct Movie: Codable {
    let id: Int?
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
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genreIDs = "genre_ids"
    }

}

// Através da API seria recebido apenas um código para ser acrescentado num URL. Esse método recebe o código adiciona na URL, e então faz a solicitacao dos dados.
extension UIImage {
func posterPath_ToImage (imageKey: String?) -> UIImage {
    
    guard let imageKey = imageKey else {return UIImage(named: "photodefault")!}
   
    let urlImage = URL(string: "https://image.tmdb.org/t/p/w500/\(imageKey)")!
    let imageData: Data = try! Data(contentsOf: urlImage)
    return UIImage(data: imageData)!
}
}




