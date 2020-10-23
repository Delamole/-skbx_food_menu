
//сделать расширение для клавиатуры и анимации
//проверка на емайл
//загрузчик
//свайпы
//инпутмаск
//глобальная переменная

import UIKit

var promoCode: PromoDescription? = nil

protocol ProductDelegate{
    func update(sale: Int)
}

class AddPromoViewController: UIViewController {
    
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var checkImage: UIImageView!
    
    @IBOutlet weak var successButton: AcceptButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var headLabel: UILabel!
   
    
    @IBOutlet weak var addPromoView: UIView!
    @IBOutlet weak var addPromoTextField: UITextField!
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var incorrectLabel: UILabel!
    
    var keyboardHeight: CGFloat = 0
    
    var delegate: ProductDelegate?
   
    
    var error = ""
    
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.update(sale: 15)
    }
    
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    
    @IBAction func acceptAction(_ sender: Any) {
        
        Loader().fetch(structData: DataPromoDescription.self, url: "http://85.119.145.2/api/user/\(id)/promo-codes/activate", httpMethod: HttpMethod.post, parameters: ["code": "\(addPromoTextField.text ?? "")"], completion: { (data) in
           
            promoCode = data.data
            print(promoCode)
            
            self.checkImage.isHidden = false
            self.successButton.isHidden = false
            self.descriptionLabel.isHidden = false
            self.headLabel.isHidden = false

            self.addPromoView.isHidden = true
            self.headLabel.text = "Промокод активирован"
            self.descriptionLabel.text = promoCode?.description ?? ""
            //            "По этому промокоду для вас действует скидка 50% в сети магазинов Перекрёсток, Лента, Мясновъ (срок действия – 30 дней)"
            self.image1.isHidden = true
            self.image2.isHidden = true
            self.image3.isHidden = true
        //            }
        }, completionError: {
            (errorReq) in self.error = errorReq.error
            print(errorReq.error)
            self.lineView.backgroundColor = UIColor(hexString: "#FF3B30", alpha: 1)
            self.incorrectLabel.isHidden = false
            self.incorrectLabel.text = self.error
            
        })
        
}
    
    @IBAction func enterPromo(_ sender: Any) {
        
        incorrectLabel.text = ""
        lineView.backgroundColor = UIColor(hexString: "#D0D0D0", alpha: 1)
        
        if addPromoTextField.text!.count == 8 {
            acceptButton.backgroundColor = UIColor(hexString: "#3D3BFF", alpha: 1)
            lineView.backgroundColor = UIColor(hexString: "#3D3BFF", alpha: 1)
        }else{
            acceptButton.backgroundColor = UIColor(hexString: "#D0D0D0", alpha: 1)
            lineView.backgroundColor = UIColor(hexString: "#D0D0D0", alpha: 1)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkImage.isHidden = true
        successButton.isHidden = true
        descriptionLabel.isHidden = true
        headLabel.isHidden = true
        incorrectLabel.isHidden = true
        
        
        addPromoTextField.text = "R-"
        addPromoTextField.becomeFirstResponder()
        acceptButton.backgroundColor = UIColor(hexString: "#D0D0D0", alpha: 1)
        lineView.backgroundColor = UIColor(hexString: "#D0D0D0", alpha: 1)
        
//        DispatchQueue.main.async {
            let center = NotificationCenter.default
            center.addObserver(self, selector: #selector(self.keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        }
       addPromoView.isHidden = false
   

    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        keyboardHeight = (notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as! CGRect).height
       self.bottomConstraint.constant = 0
        
        print("var keyboardHeight: \(keyboardHeight)")
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.bottomConstraint.constant -= self.keyboardHeight
                     },
                         completion:{ finished in
                           print("View is showed")
                })
  
    }
}
