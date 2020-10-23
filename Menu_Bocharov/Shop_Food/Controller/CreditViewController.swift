
import UIKit

var user_credit: CreditModel? = nil

protocol CreditDelegate{
    func update(credit: Int)
}

class CreditViewController: UIViewController {

    @IBOutlet weak var upConstr: NSLayoutConstraint!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var creditLabel: UILabel!
    
    var delegate: CreditDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upConstr.constant = 0.6 * view.bounds.height
        
        view.backgroundColor = .clear
        mainView.layer.cornerRadius = 15
        allButton.backgroundColor = activButtonColor
        allButton.layer.cornerRadius = 15
        
        
        LoadModel.shared.loadCredit { (data) in
            user_credit = data.data
            print("user_credit: \(data)")
            self.creditLabel.text = "\(user_credit!.credit)"
  
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "enterCredit",
        let vc = segue.destination as? EnterCreditViewController
         {
            vc.delegate = self
         }
    }
    

    @IBAction func allAction(_ sender: Any) {
        
        myBasket.credit = user_credit?.credit ?? 0
        delegate?.update(credit: user_credit?.credit ?? 0)
        dismiss(animated: true, completion: nil)
    }
    
}


extension CreditViewController: EnterCreditDelegate{
    func updateCredit(credit: Int) {
        delegate?.update(credit: credit)
        dismiss(animated: true, completion: nil)
//        if (credit != nil){
//            countBaly.isHidden = false
//            balyImage.isHidden = true
//            balyView.backgroundColor = .systemGray6
//            countBaly.text = "\(credit)"
//
//            oldPriceLabel.isHidden = false
//            oldPriceLabel.attributedText = commonPriceLabel.text!.strikeThrough()
//            commonPriceLabel.text = "\(myBasket.price - credit)"
//
//        }
    }
}
