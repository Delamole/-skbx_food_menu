import UIKit

class DetailShopViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var categoryList: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var upConstr: NSLayoutConstraint!
    var shop: DetailShop? = nil
    var id_shop = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upConstr.constant = 0.3 * view.bounds.height
        
        view.backgroundColor = .clear
        mainView.layer.cornerRadius = 15
        self.nameLabel.textColor = activButtonColor
        
        LoadModel.shared.loadDetailShop(id_shop: "\(id_shop)") { (data) in
            self.shop = data.data
            print("categories: \(data)")
            self.addressLabel.text = self.shop?.address
            self.timeLabel.text = self.shop?.schedule
            self.descriptionLabel.text = self.shop?.description
            self.nameLabel.text = self.shop?.name
            
            var cat = ""
            for i in self.shop!.categories{
                cat = cat + " * \(i.name)"
            }
            
            self.categoryList.text = cat
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
