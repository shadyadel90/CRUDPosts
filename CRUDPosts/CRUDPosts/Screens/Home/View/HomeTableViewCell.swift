import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPost: UIImageView!
    
    @IBOutlet weak var lblPostTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
