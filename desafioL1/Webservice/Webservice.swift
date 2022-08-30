import Foundation

class Webservice {
    
    func getData(url: URL, completion: @escaping ([Movie]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
            print(error.localizedDescription)
            }
            
            else if let data = data {
                
            let result = try? JSONDecoder().decode(Results.self, from: data)
            
                if let result = result {
                    completion(result.results)
                    print(result)
                }
        }
        }.resume()
}
}
