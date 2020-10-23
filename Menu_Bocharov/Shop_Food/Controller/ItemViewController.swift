
import UIKit



class ItemViewController: UIViewController {

    @IBOutlet weak var commonPrice: UILabel!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var nameController: UILabel!
    @IBOutlet weak var maneSubcategories: UILabel!
    @IBOutlet weak var collectionItems: UICollectionView!
    
    @IBOutlet weak var collectionSubItem: UICollectionView!
    var nameContr = ""
    var nameSubCat = ""
    var id_cat = 0
    var id_subcat = 0
    var id_shop = 0
    
    
    var items1: [Product] = []
    var data1: [Product] = []
    var subs1: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        upConstr.constant = 0.15 * view.bounds.height
        
        if myBasket.prods.count == 0{
            orderView.isHidden = true
        }
        view.backgroundColor = .clear
        
        mainView.layer.cornerRadius = 15
        
        nameController.text = nameContr
        maneSubcategories.text = nameSubCat
        
        if myBasket.products.count != 0{
            orderView.isHidden = false
            orderView.layer.cornerRadius = 15
            orderView.backgroundColor = activButtonColor
            commonPrice.text = "\(myBasket.price)"
        }

        
        LoadModel.shared.loadProduct(id_shop: "\(id_shop)", id_cat: "\(id_cat)", id_subcat:"\(id_subcat)") { (data) in self.data1 = data

            for i in self.data1{
                if i.is_category == false {
                    self.items1.append(i)
                    print("Цена равна \(i.price)")
                } else {
                    self.subs1.append(i)
                }
            }
            self.collectionItems.reloadData()
            self.collectionSubItem.reloadData()
        }
        
    }
    

    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toBasketAction(_ sender: Any) {
    }
}


extension ItemViewController: UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if collectionView == collectionItems{
        let w = UIScreen.main.bounds.width/2.5
        
        return CGSize(width: w, height: w)
        } else {
            let w = UIScreen.main.bounds.width/1
            return CGSize(width: w, height: w)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == collectionItems{
        return items1.count
        } else {
            return subs1.count
        }
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if collectionView == collectionItems{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        
        if items1[indexPath.row].is_category == false {
        cell.descrItem.text=items1[indexPath.row].name
        cell.priceItem.text="\(items1[indexPath.row].price) руб"
        cell.weightItem.text="\(items1[indexPath.row].weight) \(items1[indexPath.row].unit)"
        
        LoadModel.shared.loadImage(icon: items1[indexPath.row].icon) { (data) in
            cell.imageItem.image = data
        }
        }
            cell.contentView.layer.cornerRadius = 15
            cell.viewBack.dropShadow(color: .systemGray6, opacity: 2, offSet: CGSize(width: 1, height: 1), radius: 5, scale: true)
        return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubItemCollectionViewCell", for: indexPath) as! SubItemCollectionViewCell
            
            if subs1[indexPath.row].is_category == true {
                cell.nameSubItem.text=subs1[indexPath.row].name
     
            }
            cell.layer.cornerRadius = 10
            cell.backgroundColor = subs1[indexPath.row].color
         
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("item at \(indexPath.section)/\(indexPath.item) tapped")
        
        if collectionView == collectionItems{
            let selectedName = items1[indexPath.row]
      
            let newView: OneProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "OneProductViewController") as! OneProductViewController
            newView.id_product=selectedName.id
            newView.id_shop=id_shop
            newView.delegate = self
   
            present(newView, animated: true, completion: nil)
            
        } else {
            LoadModel.shared.loadProduct(id_shop: "\(id_shop)", id_cat: "\(id_cat)", id_subcat:"\(subs1[indexPath.row].id)") { (data) in self.data1 = data
                self.items1.removeAll()
                for i in self.data1{
                    if i.is_category == false {
                        self.items1.append(i)
                    } else {
                        self.subs1.append(i)
                    }
                }
                
                for i in self.subs1{
                    i.color = .white
                }
                self.subs1[indexPath.row].color = .systemGray6
                self.collectionItems.reloadData()
                self.collectionSubItem.reloadData()
            }
        }

    }
    
}

extension ItemViewController: UpdateBusketDelegate{
    func isBusketEmpty() {
        
            orderView.isHidden = false
            orderView.layer.cornerRadius = 15
            orderView.backgroundColor = activButtonColor
            commonPrice.text = "\(myBasket.price)"
            print(myBasket)
        
    }
    
    
}
