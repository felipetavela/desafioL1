import Foundation

// Lista de filmes.(Array contendo todos os filmes)
struct MoviesListViewModel {
    let movies: [Movie]
}


// Definicao das propriedas necessárias na TableViewDataSource e CollectionViewDataSource
extension MoviesListViewModel {
    var numberofSection: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.movies.count
    }
    
    // Método que irá retornar um filme no especifico lugar do array.
    func moviesAtIndex (_ index: Int) -> MovieViewModel {
        let movie = self.movies[index]
        return MovieViewModel(movie)
    }
}

// Struct contendo as propriedades que irão ser mostradas na View.
struct MovieViewModel {
    let movie: Movie
}

// Inicialização da mesma.
extension MovieViewModel {
    init(_ movies: Movie) {
        self.movie = movies
    }
}

// Inicializacao da propriedadeo. Levando se em conta que alguns filmes não possuem certos dados as propridades foram criadas na Model como opcionais e aqui foi feita a verificacao.
extension MovieViewModel {
    var id: Int {
        if self.movie.id != nil {
            return self.movie.id!
        } else {return 0}
    }
    
    var title: String {
        if self.movie.title != nil {
            return self.movie.title!
        } else {return "Sem título"}
    }
    
    var originalTitle: String {
        if self.movie.originalTitle != nil {
            return self.movie.originalTitle!
        } else {return "Sem título original"}
    }
    
    var overview: String {
        if self.movie.overview != nil {
            return self.movie.overview!
        } else {return "Sem sinópse"}
    }
    
    var posterPath: String? {
        if self.movie.posterPath != nil {
            return self.movie.posterPath!
        } else {return nil}
    }
    
    var releaseDate: String {
        if self.movie.releaseDate != nil {
            return self.movie.releaseDate!
        } else {return ""}
    }
    
    var voteAverage: Double {
        if self.movie.voteAverage != nil {
            return self.movie.voteAverage!
        } else {return 0}
    }
    
    var genreIDs: String {
        if self.movie.genreIDs.first != nil {
            switch self.movie.genreIDs.first! {
            case 28: return "Ação"
            case 12: return "Animação"
            case 35: return "Comédia"
            case 80: return "Crime"
            case 99: return "Documnetário"
            case 18: return "Drama"
            case 10751: return "Família"
            case 14: return "Fantasia"
            case 36: return "História"
            case 27: return "Terror"
            case 10402: return "Música"
            case 9648: return "Mistério"
            case 10749: return "Romance"
            case 878: return "Ficção científica"
            case 10770: return "Cinema TV"
            case 53: return "Thriller"
            case 10752: return "Guerra"
            case 37: return "Faroeste"
            default: return "-"
            }
        } else {return "-"}
    }
    
    // Foi verificado através da documentacao cada id e seu gênero conrrespondente, baseado nisso foi criado este método que irá receber o ID e transformálo na string respectiva.
    func changeGenreIDToString (id: Int) -> String? {
        switch id {
        case 28: return "Ação"
        case 12: return "Animação"
        case 35: return "Comédia"
        case 80: return "Crime"
        case 99: return "Documnetário"
        case 18: return "Drama"
        case 10751: return "Família"
        case 14: return "Fantasia"
        case 36: return "História"
        case 27: return "Terror"
        case 10402: return "Música"
        case 9648: return "Mistério"
        case 10749: return "Romance"
        case 878: return "Ficção científica"
        case 10770: return "Cinema TV"
        case 53: return "Thriller"
        case 10752: return "Guerra"
        case 37: return "Faroeste"
        default: return nil
        }
    }
    
    // Método responsável por transformar o formato da dataFormat"yyyy-MM-dd" em ""dd/MM/yyyy""
    static func formattedDateFromString(dateString: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let date = inputFormatter.date(from: dateString)!
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        return outputFormatter.string(from: date)
    }
}


