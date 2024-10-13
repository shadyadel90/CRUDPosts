import UIKit

class DetailsViewModel {

    let network: deleteAndUpdatePosts = NetworkService()

    var didDeletePost: (() -> Void)?
    var didUpdatePost: (() -> Void)?

    func deletePost(withId id: Int) {
        network.deletePost(id: id)
        didDeletePost?()
    }

    func updatePost(id: Int, title: String, message: String, image: UIImage?) {
        network.updatePost(id: id, title: title, message: message, image: image)
        didUpdatePost?()
    }
}
