import UIKit

class NewPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    let network: createNewPost = NetworkService()
    
    @IBOutlet weak var imgNewPostImage: UIImageView!
    
    @IBOutlet weak var txtNewPostTitle: UITextField!
    
    @IBOutlet weak var txtNewPostMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgNewPostImage.isUserInteractionEnabled = true
        imgNewPostImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Create New Post"
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgNewPostImage.image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true)
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
