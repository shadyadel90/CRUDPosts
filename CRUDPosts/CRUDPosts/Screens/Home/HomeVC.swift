import UIKit

class HomeVC: UITableViewController {

    let network: NetworkRepository = NetworkService()
    var posts = [Post]()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        network.fetchDataFromApi { result in
            switch result {
            case .success(let success):
                self.posts = success
                self.fetchImages()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    private func fetchImages() {
        let dispatchGroup = DispatchGroup()
        
        for item in posts {
            guard item.image != nil else { continue }
            dispatchGroup.enter()
            network.downloadImage(imageUrl: item.image!) { result in
                switch result {
                case .success(let image):
                    self.images.append(image)
                case .failure(let error):
                    self.images.append(UIImage(named: "Image")!)
                    print(error)
                    //self.showError?(ErrorMessage.invalidData .rawValue)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else { return HomeTableViewCell() }
        
        cell.lblPostTitle.text = posts[indexPath.row].title
        cell.imgPost.image = images[indexPath.row]
        cell.imgPost.layer.cornerRadius = cell.imgPost.frame.size.width / 2
        cell.imgPost.layer.masksToBounds = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        destVC.post = posts[indexPath.row]
        destVC.img = images[indexPath.row]
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    //MARK: Bar Button Action
    @IBAction func clickedAddButton(_ sender: UIBarButtonItem) {
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "NewPostVC") as! NewPostVC
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}
