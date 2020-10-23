import UIKit

var answer: AnswerBasket? = nil

class PayViewController: UIViewController {
    
    @IBOutlet weak var upConstr: NSLayoutConstraint!
    @IBOutlet weak var horView2: UIView!
    @IBOutlet weak var horView1: UIView!
    @IBOutlet weak var chargeView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var chargeLabel: UILabel!
    @IBOutlet weak var payMethodTable: UITableView!
    @IBOutlet weak var nameAdsress: UILabel!
    
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var descriptionAddress: UILabel!
    
    var paymethods = PayMethod.getnames()
   var preindex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upConstr.constant = 0.25 * view.bounds.height
        
        view.backgroundColor = .clear
        mainView.layer.cornerRadius = 15
        payView.backgroundColor = activButtonColor
        payView.layer.cornerRadius = 15
        
        horView1.backgroundColor = horlineView
        horView2.backgroundColor = activButtonColor
        
        nameAdsress.text = myBasket.nameAdr
        descriptionAddress.text = myBasket.to
        priceLabel.text = "\(myBasket.price)"

    }
    

    @IBAction func openBanknote(_ sender: Any) {
    }
    
    @IBAction func openThank(_ sender: Any) {

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "banknote",
        let vc = segue.destination as? BanknoteViewController
         {
            
            vc.delegate = self
         }
        
        if  segue.identifier == "showThank",
        let vc = segue.destination as? ThankViewController
         {
        
         }
    }

    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PayViewController: UITableViewDataSource, UITableViewDelegate{
    

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return paymethods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PayTableViewCell") as! PayTableViewCell

        cell.initCell(item: paymethods[indexPath.row])
       
        return cell
    }
    
    func myUpdate(){
        paymethods[preindex].check = "grayButton"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch paymethods[indexPath.row].name {
        case "Наличные":
            chargeView.isHidden = false
            myBasket.payment_method = "cash"
            myUpdate()
            preindex = indexPath.row
            paymethods[indexPath.row].check = "greenButton"
            tableView.reloadData()
            payLabel.text = "Заказать"
        case "Карта **** 2045":
            chargeView.isHidden = true
            myBasket.payment_method = "card"
            myUpdate()
            preindex = indexPath.row
            paymethods[indexPath.row].check = "greenButton"
            tableView.reloadData()
            payLabel.text = "Оплатить"
        case "Apple Pay":
            chargeView.isHidden = true
            myBasket.payment_method = "applepay"
            myUpdate()
            preindex = indexPath.row
            paymethods[indexPath.row].check = "greenButton"
            tableView.reloadData()
            payLabel.text = "Оплатить"
        default:
            myBasket.payment_method = "cash"
        }
    }
}

extension PayViewController: GetChargeProtocolDelegate{
    func getCharge(charge: Int) {
        chargeLabel.text = "c \(charge) руб"
    }
    
    
}
