import UIKit

class BasketViewController: UIViewController {

  
    @IBOutlet weak var upConstr: NSLayoutConstraint!
    @IBOutlet weak var horView: UIView!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var balyView: UIView!
    @IBOutlet weak var promoView: UIView!
    @IBOutlet weak var countBaly: UILabel!
    @IBOutlet weak var countPromo: UILabel!
    @IBOutlet weak var balyLabel: UILabel!
    @IBOutlet weak var balyImage: UIImageView!
    @IBOutlet weak var promoLabel: UILabel!
    @IBOutlet weak var promoImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableOrder: UITableView!
    @IBOutlet weak var nameController: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var commonPriceLabel: UILabel!
    @IBOutlet weak var orderView: UIView!
    
   var old_price = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upConstr.constant = 0.25 * view.bounds.height

        
        view.backgroundColor = .clear
        mainView.layer.cornerRadius = 15
        orderView.backgroundColor = activButtonColor
        orderView.layer.cornerRadius = 15
        horView.backgroundColor = horlineView

        countBaly.isHidden = true
        countPromo.isHidden = true
        oldPriceLabel.isHidden = true
        promoView.dropShadow(color: .systemGray6, opacity: 2, offSet: CGSize(width: 1, height: 1), radius: 5, scale: true)
        balyView.dropShadow(color: .systemGray6, opacity: 2, offSet: CGSize(width: 1, height: 1), radius: 5, scale: true)
        
        commonPriceLabel.text = "\(myBasket.price)"
        old_price = myBasket.price
    }
    
    @IBAction func clearBusket(_ sender: Any) {
    }
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendOrder(_ sender: Any) {
        
    }
    
    @IBAction func balyAction(_ sender: Any) {
        let newView: CreditViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreditViewController") as! CreditViewController
        newView.delegate=self
       
        present(newView, animated: true, completion: nil)
        
    }
    
  
    
    @IBAction func promoAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "promo", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddPromoViewController") as! AddPromoViewController
        newViewController.delegate = self
                self.present(newViewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
    }
    
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate{
    

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return myBasket.prods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell") as! BasketTableViewCell

        cell.initCell(item: myBasket.prods[indexPath.row])
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}


extension BasketViewController: ProductDelegate{
    func update(sale: Int) {
        if (promoCode != nil){
            countPromo.isHidden = false
            promoImage.isHidden = true
            promoView.backgroundColor = .systemGray6
            countPromo.text = "\(sale)%"
            
            oldPriceLabel.isHidden = false
            oldPriceLabel.attributedText = commonPriceLabel.text!.strikeThrough()
            myBasket.price = Int(0.85 * Double(myBasket.price))
            old_price = myBasket.price
            commonPriceLabel.text = "\(myBasket.price)"
            myBasket.promo_codes.append(promoCode!.description)
        }
    }
}

extension BasketViewController: CreditDelegate{
    func update(credit: Int) {
        if (credit != nil){
            countBaly.isHidden = false
            balyImage.isHidden = true
            balyView.backgroundColor = .systemGray6
            countBaly.text = "\(credit)"
            
            oldPriceLabel.isHidden = false
            oldPriceLabel.attributedText = commonPriceLabel.text!.strikeThrough()
            var cr = old_price - credit
            
            if (cr<0){
                myBasket.credit = credit - myBasket.price
                cr = 0
            }
            myBasket.price = cr
            commonPriceLabel.text = "\(cr)"
        
        }
    }
}

