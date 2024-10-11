

import UIKit

protocol NetworkRepository {
    
    func downloadImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void)
    
    func fetchDataFromApi(completion: @escaping (Result<[Post], Error>) -> Void)
}
