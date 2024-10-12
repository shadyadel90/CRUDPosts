import UIKit

class NewPostVC: UIViewController {

    let network: createNewPost = NetworkService()
    
    @IBOutlet weak var imgNewPostImage: UIImageView!
    
    @IBOutlet weak var txtNewPostTitle: UITextField!
    
    @IBOutlet weak var txtNewPostMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Create New Post"
    }
    
    
    @IBAction func addNewPostBtnClicked(_ sender: UIButton) {
        
        self.view.showLoadingIndicator()
        
        network.createPost(title: txtNewPostTitle.text ?? "Unnamed", message: txtNewPostMessage.text ?? "Undefined", image: imgNewPostImage.image ?? UIImage(named: "Image"))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view.hideLoadingIndicator()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
