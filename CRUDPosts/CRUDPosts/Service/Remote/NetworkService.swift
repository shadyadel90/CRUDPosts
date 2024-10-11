import UIKit

class NetworkService: NetworkRepository {
    
    func downloadImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: imageUrl) else {
            completion(.failure(ErrorMessage.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
               print(data)
                completion(.failure(ErrorMessage.invalidResponse))
                return
            }
            
            completion(.success(image))
        }
        task.resume()
    }
    
    func fetchDataFromApi(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)getposts") else {
            completion(.failure(ErrorMessage.unableToComplete))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                completion(.failure(ErrorMessage.invalidRequest))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                completion(.failure(ErrorMessage.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(ErrorMessage.invalidData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(result))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(ErrorMessage.unableToComplete))
            }
        }.resume()
    }
}
