import UIKit

//class NetworkService: NetworkRepository {
   
//    
//    func downloadImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
//        guard let url = URL(string: "\(Constants.imgUrl)\(imageUrl)") else {
//            completion(.failure(ErrorMessage.unableToComplete))
//            return
//        }
//
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Request error: \(error.localizedDescription)")
//                completion(.failure(ErrorMessage.invalidRequest))
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                print("Invalid response code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
//                completion(.failure(ErrorMessage.invalidResponse))
//                return
//            }
//
//            guard let data = data, let image = UIImage(data: data) else {
//                completion(.failure(ErrorMessage.invalidData))
//                return
//            }
//
//            completion(.success(image))
//        }.resume()
//    }
//    
//    func fetchDataFromApi(movieListType: MovieListType, completion: @escaping (Result<[Movie], Error>) -> Void) {
//        guard let url = URL(string: "\(Constants.baseUrl)\(movieListType.description)\(Constants.apiKey)") else {
//            completion(.failure(ErrorMessage.unableToComplete))
//            return
//        }
//        
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Request error: \(error.localizedDescription)")
//                completion(.failure(ErrorMessage.invalidRequest))
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                print("Invalid response code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
//                completion(.failure(ErrorMessage.invalidResponse))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(ErrorMessage.invalidData))
//                return
//            }
//            
//            do {
//                let result = try JSONDecoder().decode(result.self, from: data)
//                completion(.success(result.results))
//            } catch {
//                print("Decoding error: \(error.localizedDescription)")
//                completion(.failure(ErrorMessage.unableToComplete))
//            }
//        }.resume()
//    }
//}
