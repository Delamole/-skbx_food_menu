

import UIKit
import Alamofire
import AlamofireImage

class ShopViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var horizView: UIView!
    @IBOutlet weak var collectionShop: UICollectionView!
    @IBOutlet weak var descriptionAddress: UILabel!
    @IBOutlet weak var nameAddress: UILabel!
    
    @IBOutlet weak var upConstr: NSLayoutConstraint!
    var name = ""
    var descr = ""
    var shops: [Shop] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        upConstr.constant = 0.4 * view.bounds.height
        
        if name == ""{
            nameAddress.isHidden = true
        }
        view.backgroundColor = .clear
        mainView.layer.cornerRadius = 15
        
        nameAddress.text = name
        descriptionAddress.text = descr
        horizView.backgroundColor = activButtonColor
        
        LoadModel.shared.loadShop{ (data) in
            for i in data.data {
                self.shops.append(i)
            }
            self.collectionShop.reloadData()
        }
        
    }

//     override func viewWillLayoutSubviews() {
//        preferredContentSize = CGSize(width: view.bounds.width, height: collectionShop.contentSize.height)
//        }
    


}

extension ShopViewController: UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let w = UIScreen.main.bounds.width/2.5
        return CGSize(width: w, height: w/1.98)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return shops.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell
        cell.nameLabel.text=shops[indexPath.row].name
        
        LoadModel.shared.loadImage(icon: shops[indexPath.row].icon) { (data) in
            cell.imageShop.image = data
        }
        
        cell.mainView.layer.cornerRadius = 15
        cell.contentView.dropShadow(color: .systemGray6, opacity: 2, offSet: CGSize(width: 1, height: 1), radius: 5, scale: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("item at \(indexPath.section)/\(indexPath.item) tapped")
        let selectedName = shops[indexPath.row]
  
        let newView: CategoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        newView.nameOfCategory=selectedName.name
        newView.id_shop=selectedName.id
        present(newView, animated: true, completion: nil)
    }
    
}
