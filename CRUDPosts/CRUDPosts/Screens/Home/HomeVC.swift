import UIKit

class HomeVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

 
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else { return HomeTableViewCell() }
        
        cell.lblPostTitle.text = "\(Int.random(in: 1...5))"
        cell.imgPost.layer.cornerRadius = cell.imgPost.frame.size.width / 2
        cell.imgPost.layer.masksToBounds = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    //MARK: Bar Button Action
    @IBAction func clickedAddButton(_ sender: UIBarButtonItem) {
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "NewPostVC") as! NewPostVC
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}
