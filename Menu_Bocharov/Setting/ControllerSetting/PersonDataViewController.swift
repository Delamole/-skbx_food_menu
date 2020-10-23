
import UIKit



class PersonDataViewController: UIViewController {
    


    @IBOutlet weak var headPersonDataView: UIView!
    @IBOutlet weak var personDataTable: UITableView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var addDataView: UIView!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var saveDataAction: UIButton!
    
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var bottomDataView: NSLayoutConstraint!
    
    
    var personData = PersonData.getnames()
    var profile: Profile? = nil
    var indexPathSection = 0
    var indexPathRow = 0
    var keyboardHeight: CGFloat = 0
    
 func isValidEmail(_ email: String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

       let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailPred.evaluate(with: email)
   }
    
    @IBAction func correctData(_ sender: Any) {
        if (indexPathSection == 2){
            let check = self.isValidEmail(dataTextField.text ?? "")
            if check == true {
                saveDataAction.isEnabled = true
                saveDataAction.backgroundColor = UIColor(hexString: "#3D3BFF", alpha: 1)
                lineView.backgroundColor = UIColor(hexString: "#3D3BFF", alpha: 1)
            }
        }
        else{
            saveDataAction.isEnabled = true
            saveDataAction.backgroundColor = UIColor(hexString: "#3D3BFF", alpha: 1)
            lineView.backgroundColor = UIColor(hexString: "#3D3BFF", alpha: 1)
        }
    }
    
    @IBAction func saveData(_ sender: Any) {
        print(indexPathSection)
        print(indexPathRow)
        personData[indexPathSection].names[indexPathRow].namePersonData = dataTextField.text ?? ""
        //            view.backgroundColor = .red
        print(dataTextField.text ?? "")
        personDataTable.reloadData()
        personDataTable.alpha = 1
        addDataView.isHidden = true

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
        //        var basketTopFrame = self.basketTop.frame
            self.addDataView.frame.origin.y = self.view.frame.size.height
            self.bottomDataView.constant = 0
                },
                    completion:{ finished in
                      print("View is hidden")
            })
     grayView.isHidden = true
         self.view.endEditing(true)
        
        if indexPathSection == 1{
            print ("put1")
            Loader().fetch(structData: DataProfile.self, url: "http://85.119.145.2/api/user/\(id)/profile", httpMethod: HttpMethod.put, parameters: ["name": dataTextField.text], completion: { (data) in self.profile = data.data
      
        print("new profile \(self.profile)")
      
            self.personDataTable.reloadData()

                            })
        } else{
            print ("put2")
            Loader().fetch(structData: DataProfile.self, url: "http://85.119.145.2/api/user/\(id)/profile", httpMethod: HttpMethod.put, parameters: ["email": dataTextField.text], completion: { (data) in self.profile = data.data
     
                print(self.profile)
            
                  self.personDataTable.reloadData()

                                  })
        }

    }

    
  @objc func keyboardDidShow(_ notification: Notification) {
      keyboardHeight = (notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as! CGRect).height
      bottomDataView.constant = keyboardHeight
      
      print("var keyboardHeight: \(keyboardHeight)")
  }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveDataAction.backgroundColor = UIColor(hexString: "#D0D0D0", alpha: 1)
        saveDataAction.isEnabled = false
        
        let center = NotificationCenter.default
        headPersonDataView.backgroundColor = backgroundColor
      
        center.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        grayView.backgroundColor = .gray
        grayView.alpha = 0.5
        
        Loader().fetch(structData: DataProfile.self, url: "http://85.119.145.2/api/user/\(id)/profile", httpMethod: HttpMethod.get, parameters: nil, completion: { (data) in self.profile = data.data

                            print(self.profile)
            let phone = Array(data.data.phone)
            let phone_for_table = "+\(phone[0]) (\(phone[1])\(phone[2])\(phone[3])) \(phone[4])\(phone[5])\(phone[6])-\(phone[7])\(phone[8])-\(phone[9])\(phone[10])"
            self.personData[0].names[0].namePersonData = phone_for_table
            
            self.personData[1].names[0].namePersonData = data.data.name
            self.personData[2].names[0].namePersonData = data.data.email
            self.personDataTable.reloadData()

                            })
  
    }
}


extension PersonDataViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return personData[section].tittle
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            if let headerView = view as? UITableViewHeaderFooterView {
                headerView.contentView.backgroundColor = backgroundColor
                headerView.textLabel?.textColor = .black
                headerView.textLabel?.font = UIFont.systemFont(ofSize: 12)

            }
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return personData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personData[section].names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "PersonDataTableViewCell") as! PersonDataTableViewCell
   
        cell.initCell(item: personData[indexPath.section].names[indexPath.row])
        
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        if (personData[indexPath.section].names[indexPath.row].iconPerson != false){
            

            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {

                self.addDataView.frame.origin.y = self.view.frame.size.height - CGFloat(self.keyboardHeight) - self.addDataView.frame.size.height
                self.saveDataAction.backgroundColor = UIColor(hexString: "#D0D0D0", alpha: 1)
                self.saveDataAction.isEnabled = false
        },
            completion:{ finished in
              print("View is showed")
            })
            
             grayView.isHidden = false
            self.dataTextField.resignFirstResponder()
        print(self.view.frame.size.height)
//        print("keyboardY \(self.keyboardHeight)")
        addDataView.isHidden = false
        dataTextField.text = ""
        dataTextField.becomeFirstResponder()
        indexPathSection = indexPath.section
        indexPathRow = indexPath.row
        personDataTable.alpha = 0.9

        
      if (personData[indexPath.section].names[indexPath.row].namePersonData == ""){
            dataTextField.placeholder = personData[indexPath.section].names[indexPath.row].placeHolderPersonData
        }else {
        dataTextField.text = personData[indexPath.section].names[indexPath.row].namePersonData
            }

            saveDataAction.layer.cornerRadius = 15
            
            lineView.backgroundColor = UIColor(hexString: "#D0D0D0", alpha: 1)
            addDataView.backgroundColor = .white
            addDataView.alpha = 1

        }
    }

}


