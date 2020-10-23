
import UIKit
import Alamofire
import AlamofireImage

class CategoryViewController: UIViewController {

    @IBOutlet weak var upConstr: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var grayview: UIView!
    @IBOutlet weak var horView: UIView!
    @IBOutlet weak var nameController: UILabel!
    @IBOutlet weak var collectionCategory: UICollectionView!
    
    var nameOfCategory = ""
    var categories: [Category] = []
    
    var id_shop = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upConstr.constant = 0.2 * view.bounds.height
        
        nameController.text = nameOfCategory
        horView.backgroundColor = horlineView
        view.backgroundColor = .clear
        grayview.alpha = 0.5
        mainView.layer.cornerRadius = 15
        
        
        LoadModel.shared.loadCategory(id_shop: "\(id_shop)") { (data) in
            for i in data.data {
                self.categories.append(i)
                }
            print("categories: \(data)")
            self.collectionCategory.reloadData()
        }
    }
 
    @IBAction func showInfoShop(_ sender: Any) {
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "detailShop",
        let vc = segue.destination as? DetailShopViewController
         {
            vc.id_shop = id_shop
         }
    }
}


extension CategoryViewController: UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let w = UIScreen.main.bounds.width/2.5
        return CGSize(width: w, height: w)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return categories.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
       
        cell.name.text=categories[indexPath.row].name
        
        LoadModel.shared.loadImage(icon: categories[indexPath.row].icon) { (data) in
            cell.image.image = data
        }
        
        cell.contentView.layer.cornerRadius = 15

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("item at \(indexPath.section)/\(indexPath.item) tapped")
        let selectedName = categories[indexPath.row]
        
        
        let newView: ItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        newView.nameContr = selectedName.name
                newView.nameSubCat = nameOfCategory
                newView.id_subcat = selectedName.id
                newView.id_shop = id_shop
                present(newView, animated: true, completion: nil)

    }
    
}
