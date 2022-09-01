import UIKit

class EntryCollectionViewController: UIViewController {

    var moviesVC: MoviesListViewModel!
    
    var id: Int?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        movieSearchBar.setShowsCancelButton(true, animated: true)
        
        movieSearchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        setup()
    }
 
    func setup()  {
        
        let url: URL = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=a3e6584e853337c35dc545ce1db606b0&language=pt-BRinclude_video=false&primary_release_date.gte=2022-08-01&primary_release_date.lte=2022-08-30")!
        
        Webservice().getData(url: url) { movie in
            
            self.moviesVC = MoviesListViewModel(movies: movie!)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
        }
    }
}

extension EntryCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesVC.numberOfRowsInSection(section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.moviesVC == nil ? 0 : self.moviesVC.numberofSection
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionCell", for: indexPath) as? MovieCollectionViewCell else {fatalError("Movie CollectionView not found")}
        
        let movieVM = self.moviesVC.moviesAtIndex(indexPath.row)
       
        self.id = movieVM.id
        cell.titleLabel.text = movieVM.title
        cell.ratingView.layer.cornerRadius = 12
        cell.ratingLabel.text = "\(movieVM.voteAverage)"
        
        cell.posterImage.image = UIImage().imageURL_ToUIImage(imageKey: movieVM.posterPath)
        
        return cell
    }
}

extension EntryCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
           if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
            let movieVM = self.moviesVC.moviesAtIndex(indexPath.row)
            vc.movieTitle = movieVM.title
            vc.movieSubtitulo = movieVM.originalTitle
            vc.movieSinopse = movieVM.overview
            vc.imageKey = movieVM.posterPath
            vc.date = movieVM.releaseDate
            vc.voteAverage = movieVM.voteAverage
            vc.id = movieVM.id
            vc.genreString = transformGenreId_toString(id: movieVM.genreIDs)
           
            self.navigationController?.pushViewController(vc, animated: true)
        }
        }
}

extension EntryCollectionViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        guard let movie = searchBar.text else {return}
            
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=a3e6584e853337c35dc545ce1db606b0&language=pt-BRinclude_video=false&query=\(movie)")!
            
           Webservice().getData(url: url) { movie in
            
            self.moviesVC = MoviesListViewModel(movies: movie!)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.movieSearchBar.resignFirstResponder()
        self.movieSearchBar.text = ""
    }
}
 




