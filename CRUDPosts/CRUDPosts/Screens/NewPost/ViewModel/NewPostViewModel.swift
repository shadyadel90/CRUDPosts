import UIKit

class NewPostViewModel {
    
    let network: createNewPost = NetworkService()

    var didCreatePost: (() -> Void)?

    func createPost(title: String, message: String, image: UIImage?) {
        network.createPost(title: title, message: message, image: image ?? UIImage(named: "Image"))
        didCreatePost?()
    }
}
