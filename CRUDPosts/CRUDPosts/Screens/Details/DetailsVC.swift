import UIKit

class DetailsVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imgPost: UIImageView!
    
    @IBOutlet weak var txtPostTitle: UITextField!
    
    @IBOutlet weak var txtPostMessage: UITextView!
    
    
    var post = Post(id: 0, title: "Unnamed", message: "Undefiend", image: "")
    var img: UIImage?
    let network: deleteAndUpdatePosts = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPost.isUserInteractionEnabled = true
        imgPost.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Post"
        imgPost.image = img ?? UIImage(named: "Image")
        txtPostTitle.text = post.title ?? "Unnamed"
        txtPostMessage.text = post.message ?? "Undefiend"
    }
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imgPost.image = selectedImage
        }
        picker.dismiss(animated: true)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.view.hideLoadingIndicator()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
