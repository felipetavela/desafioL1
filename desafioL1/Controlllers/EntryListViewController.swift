import UIKit

class EntryListViewController: UIViewController {

    // Declaro a minha variável para obter os dados referentes a TableViewDataSource.
    var moviesVC: MoviesListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var changeStyleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.setHidesBackButton(true, animated: true)
       
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setup()
    }
    
    // Método que irá fazer a chamada da API. Como foi dito o método getData iria receber um URL, e através do completion foi inicializada a variável moviesVC e também recarregada a própria tableView, agora já com os dados necessários.
    func setup()  {
        let url: URL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a3e6584e853337c35dc545ce1db606b0&language=pt-BR&page=1")!
        
        Webservice().getData(url: url) { movie in
            self.moviesVC = MoviesListViewModel(movies: movie!)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Método para poder chamar os filmes recentes.
    @IBAction func refreshAction(_ sender: Any) {
        setup()
    }
}

// Table View Data Source que conterá todos os dados necessários para o funcionamento da TableView, esses dados provenientes da nossa MovieListViewModel.
extension EntryListViewController: UITableViewDataSource {
    
    // Criação da célula.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {fatalError("MovieTableViewCell not found")}
        
        // Aqui foi inicializado a constante movieVM, recebendo os dados do filme tendo como base a posicao do mesmo no array.
        let movieVM = self.moviesVC.moviesAtIndex(indexPath.row)
        
        // Implementação dos dados as suas respectivas vistas.
        cell.subtitleLabel.text = movieVM.originalTitle
        cell.titleLabel.text = movieVM.title
        cell.ratingLabel.text = "⭐️  \(movieVM.voteAverage)"
        cell.posterImage.image = UIImage().posterPath_ToImage(imageKey: movieVM.posterPath)
        // Condicional necessária para não ficar um espaço vago entre os textos.
        if changeGenreIDToString(id: movieVM.genreIDs) != nil {
        cell.genreLabel.text = changeGenreIDToString(id: movieVM.genreIDs)
        }
    
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.moviesVC == nil ? 0 : self.moviesVC.numberofSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesVC.numberOfRowsInSection(section)
    }
}

// Método TableViewDelegate que irá identificar o toque na célular e enviará os dados a proxíma tela.
extension EntryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
               
            let movieVM = self.moviesVC.moviesAtIndex(indexPath.row)
            
            vc.movieTitle = movieVM.title
            vc.movieSubtitle = movieVM.originalTitle
            vc.movieOverview = movieVM.overview
            vc.imageKey = movieVM.posterPath
            vc.date = movieVM.releaseDate
            vc.id = movieVM.id
            vc.voteAverage = movieVM.voteAverage
            vc.genreString = changeGenreIDToString(id: movieVM.genreIDs)
           
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// Método SearchBarDelegate que irá identificar o toque no botão buscar, como também do botão cancelar.
extension EntryListViewController: UISearchBarDelegate {
   
    // Quando o botão ˜buscar˜ for clicado irá identificar o conteúdo da barra de texto e fará uma nova solicitação da API.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let movie = searchBar.text else { return }
            
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=a3e6584e853337c35dc545ce1db606b0&language=pt-BRinclude_video=false&query=\(movie)")!
            
           Webservice().getData(url: url) { movie in
            self.moviesVC = MoviesListViewModel(movies: movie!)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Quando o botão "cancel" for clicado irá fechar o teclado e apagar o texto da barra de texto
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchBar.text = ""
    }
}
 



