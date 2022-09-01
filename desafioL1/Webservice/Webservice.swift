import Foundation

// Classe de consumo da API.
class Webservice {

    // Funcao de consumo da API. Esse método recebe um URL, e através dele recebe dados que serão codificados tendo como base a struct Result. Aprensenta também condicionais verificando os valores nil através do guard let.
    func getData(url: URL, completion: @escaping ([Movie]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
        
            guard let data = data else { return }
            let result = try? JSONDecoder().decode(Results.self, from: data)
            
            guard let result = result else { return }
            completion(result.results)
                 
        }.resume()
    }
}

