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

}


