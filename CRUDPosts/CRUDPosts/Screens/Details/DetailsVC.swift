import UIKit

class DetailsVC: UIViewController {

    
    @IBOutlet weak var imgPost: UIImageView!
    
    @IBOutlet weak var txtPostTitle: UITextField!
    
    @IBOutlet weak var txtPostMessage: UITextView!
    
    
    var post = Post(id: 0, title: "Unnamed", message: "Undefiend", image: "")
    var img: UIImage?
    let network: deleteAndUpdatePosts = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Post"
        imgPost.image = img ?? UIImage(named: "Image")
        txtPostTitle.text = post.title ?? "Unnamed"
        txtPostMessage.text = post.message ?? "Undefiend"
    }
    
    @IBAction func deletePostBtnClicked(_ sender: UIButton) {
        guard let id = post.id else { return }
        network.deletePost(id: id)
        self.view.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.view.hideLoadingIndicator()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func updatePostBtnClicked(_ sender: UIButton) {
        self.view.showLoadingIndicator()
        network.updatePost(id: post.id!, title: txtPostTitle.text ?? "Unknown Title", message: txtPostMessage.text ?? "Unknown Message", image: imgPost.image)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.view.hideLoadingIndicator()
                self.navigationController?.popViewController(animated: true)
            }
    }
    
}
