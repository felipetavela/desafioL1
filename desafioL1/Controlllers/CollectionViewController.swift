import UIKit

// Está classe é identica a classe da TableView, com diferença na nomeclatura Row para Item no DataSource.

class CollectionViewController: UIViewController {
    
    var moviesVC: MoviesListViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    var imagens: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        movieSearchBar.setShowsCancelButton(true, animated: true)
        movieSearchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesVC.numberOfRowsInSection(section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.moviesVC == nil ? 0 : self.moviesVC.numberofSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionCell", for: indexPath) as? MovieCollectionViewCell else {fatalError("Movie CollectionViewCell not found")}
        
        let movieVM = self.moviesVC.moviesAtIndex(indexPath.row)
       
        cell.titleLabel.text = movieVM.title
        cell.ratingView.layer.cornerRadius = 12
        cell.ratingLabel.text = "\(movieVM.voteAverage)"
//        cell.posterImage.image = imagens[indexPath.row]
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            
         let movieVM = self.moviesVC.moviesAtIndex(indexPath.row)
         vc.movieVM = movieVM
         
         self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CollectionViewController: UISearchBarDelegate {
   
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
 




