import UIKit

protocol FetchDatafromNetwork {
    func downloadImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void)
    func fetchDataFromApi(completion: @escaping (Result<[Post], Error>) -> Void)
}

protocol deleteAndUpdatePosts {
    func deletePost(id: Int)
    func updatePost(id: Int, title: String, message: String, image: UIImage?)
}

protocol createNewPost {
    func createPost(title: String, message: String, image: UIImage?)
}
