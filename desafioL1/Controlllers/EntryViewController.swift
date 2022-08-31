import UIKit

class EntryViewController: UIViewController {

    var moviesVC: MoviesListViewModel!
    
    var id: Int?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchBar.setShowsCancelButton(true, animated: true)
        
        movieSearchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        setup()
    }
    
    
    func setup()  {
        
        let url: URL = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=a3e6584e853337c35dc545ce1db606b0&language=pt-BRinclude_video=false&primary_release_date.gte=2022-08-01&primary_release_date.lte=2022-08-30")!
        
        Webservice().getData(url: url) { movie in
            
            self.moviesVC = MoviesListViewModel(movies: movie!)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
}

extension EntryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell else {fatalError("ArticleTableViewCell not found")}
        
        let movieVM = self.moviesVC.moviesAtIndex(indexPath.row)
        
        self.id = movieVM.id
        print(movieVM.id)
        cell.subtitleLabel.text = movieVM.originalTitle
        cell.titleLabel.text = movieVM.title
    
        cell.posterImage.image = imageURL_ToUIImage(imageKey: movieVM.posterPath)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.moviesVC == nil ? 0 : self.moviesVC.numberofSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesVC.numberOfRowsInSection(section)
    }
    
    
}

extension EntryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
            let movieVM = self.moviesVC.moviesAtIndex(indexPath.row)
            vc.movieTitle = movieVM.title
            vc.movieSubtitulo = movieVM.originalTitle
            vc.movieSinopse = movieVM.overview
            vc.imageKey = movieVM.posterPath
            vc.date = movieVM.releaseDate
           
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension EntryViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        guard let movie = searchBar.text else {return}
            
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=a3e6584e853337c35dc545ce1db606b0&language=pt-BRinclude_video=false&query=\(movie)")!
            
           Webservice().getData(url: url) { movie in
            
            self.moviesVC = MoviesListViewModel(movies: movie!)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
 



