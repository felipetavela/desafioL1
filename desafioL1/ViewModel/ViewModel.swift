import Foundation

struct MoviesListViewModel {
    let movies: [Movie]
}

extension MoviesListViewModel {
    
    var numberofSection: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.movies.count
    }
    
    func moviesAtIndex (_ index: Int) -> MovieViewModel {
        let movie = self.movies[index]
        return MovieViewModel(movie)
    }
}

struct MovieViewModel {
    
    let movie: Movie

}

extension MovieViewModel {
    init(_ movies: Movie) {
        self.movie = movies
    }
}

extension MovieViewModel {
    var id: Int {
       
        if self.movie.id != nil {
        return self.movie.id!
        } else {return 0}
    }
    
    var imdbID: String {
        if self.movie.imdbID != nil {
            return self.movie.imdbID!
        } else {return ""}
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
    
    var posterPath: String {
        if self.movie.posterPath != nil {
            return self.movie.posterPath!
        } else {return ""}
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
    
    var genreIDs: Int {
        if self.movie.id != nil {
            return self.movie.genreIDs[0]
        } else {return 0 }
    }

}

func transformGenreId_toString (id: Int) -> String? {
    
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



