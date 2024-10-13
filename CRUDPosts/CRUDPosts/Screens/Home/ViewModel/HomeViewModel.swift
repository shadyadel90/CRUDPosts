import UIKit

class HomeViewModel {

    let network: FetchDatafromNetwork = NetworkService()
    var posts = [Post]()
    var images = [UIImage]()

    var didUpdateData: (() -> Void)?

    func fetchPosts() {
        network.fetchDataFromApi { [weak self] result in
            switch result {
            case .success(let success):
                self?.posts = success
                self?.didUpdateData?()
                self?.fetchImages()
            case .failure(let failure):
                print(failure)
            }
        }
    }

    private func fetchImages() {
        let dispatchGroup = DispatchGroup()

        for item in posts {
            guard let imageUrl = item.image else { return }
            dispatchGroup.enter()
            network.downloadImage(imageUrl: imageUrl) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.images.append(image)
                case .failure:
                    self?.images.append(UIImage(named: "Image")!)
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.didUpdateData?()
        }
    }

    func numberOfMovies() -> Int {
        return posts.count
    }

    func didSelectMovie(at index: Int) -> Post? {
        guard index >= 0 && index < posts.count else {
            return nil
        }
        return posts[index]
    }

    func didSelectImage(at index: Int) -> UIImage? {
        guard index >= 0 && index < images.count else {
            return nil
        }
        return images[index]
    }
}
