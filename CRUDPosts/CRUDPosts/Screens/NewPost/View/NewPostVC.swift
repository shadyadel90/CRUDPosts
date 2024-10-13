import UIKit

class NewPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var imgNewPostImage: UIImageView!
    @IBOutlet weak var txtNewPostTitle: UITextField!
    @IBOutlet weak var txtNewPostMessage: UITextView!
    
    private var viewModel = NewPostViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        imgNewPostImage.isUserInteractionEnabled = true
        imgNewPostImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

    private func bindViewModel() {
        viewModel.didCreatePost = { [weak self] in
            DispatchQueue.main.async {
                self?.view.hideLoadingIndicator()
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }

    @IBAction func addNewPostBtnClicked(_ sender: UIButton) {
        self.view.showLoadingIndicator()

        let title = txtNewPostTitle.text ?? "Unnamed"
        let message = txtNewPostMessage.text ?? "Undefined"
        let image = imgNewPostImage.image ?? UIImage(named: "Image")

        viewModel.createPost(title: title, message: message, image: image)
    }
}
