import UIKit

class HomeVC: UITableViewController {

    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.fetchPosts()
    }

    private func bindViewModel() {
        viewModel.didUpdateData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else { return HomeTableViewCell() }

        if let post = viewModel.didSelectMovie(at: indexPath.row) {
            cell.lblPostTitle.text = post.title
        }

        if let image = viewModel.didSelectImage(at: indexPath.row) {
            cell.imgPost.image = image
            cell.imgPost.layer.cornerRadius = cell.imgPost.frame.size.width / 2
            cell.imgPost.layer.masksToBounds = true
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let post = viewModel.didSelectMovie(at: indexPath.row),
           let image = viewModel.didSelectImage(at: indexPath.row) {
            let destVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
            destVC.post = post
            destVC.img = image
            self.navigationController?.pushViewController(destVC, animated: true)
        }
    }

    //MARK: Bar Button Action
    @IBAction func clickedAddButton(_ sender: UIBarButtonItem) {
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "NewPostVC") as! NewPostVC
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}
