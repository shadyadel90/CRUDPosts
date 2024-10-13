import UIKit

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var txtPostTitle: UITextField!
    @IBOutlet weak var txtPostMessage: UITextView!

    var post = Post(id: 0, title: "Unnamed", message: "Undefined", image: "")
    var img: UIImage?

    private var viewModel = DetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        imgPost.isUserInteractionEnabled = true
        imgPost.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))
        imgPost.image = img ?? UIImage(named: "Image")
        txtPostTitle.text = post.title
        txtPostMessage.text = post.message
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Post"
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
            img = selectedImage
        }
        picker.dismiss(animated: true)
    }

    private func bindViewModel() {
        viewModel.didDeletePost = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.view.hideLoadingIndicator()
                self?.navigationController?.popViewController(animated: true)
            }
        }

        viewModel.didUpdatePost = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self?.view.hideLoadingIndicator()
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }

    @IBAction func deletePostBtnClicked(_ sender: UIButton) {
        guard let id = post.id else { return }
        self.view.showLoadingIndicator()
        viewModel.deletePost(withId: id)
    }

    @IBAction func updatePostBtnClicked(_ sender: UIButton) {
        guard let id = post.id else { return }
        self.view.showLoadingIndicator()
        viewModel.updatePost(
            id: id,
            title: txtPostTitle.text ?? "Unknown Title",
            message: txtPostMessage.text ?? "Unknown Message",
            image: imgPost.image
        )
    }
}
