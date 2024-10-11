import UIKit

class DetailsVC: UIViewController {

    
    @IBOutlet weak var imgPost: UIImageView!
    
    @IBOutlet weak var txtPostTitle: UITextField!
    
    @IBOutlet weak var txtPostMessage: UITextView!
    
    
    var post: Post?
    var img: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Post"
        imgPost.image = img ?? UIImage(named: "Image")
        txtPostTitle.text = post?.title ?? "UnNamed"
        txtPostMessage.text = post?.message ?? "UnDefiend"
    }
    
}
