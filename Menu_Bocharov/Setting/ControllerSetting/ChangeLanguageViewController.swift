
import UIKit

protocol ChangeLanguageProtocol {
    func setLanguage(language: String)
}

class ChangeLanguageViewController: UIViewController {

    @IBOutlet weak var languageTable: UITableView!
    @IBOutlet weak var headLanguageView: UIView!
    
    var languages: [Language] = [Language(name: "Русский", buttonImage: "greenButton"),
                                 Language(name: "Английский", buttonImage: "grayButton")
    ]
    var setLanguage = ""
    var switchSetting: Settings? = nil
    var delegate: ChangeLanguageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headLanguageView.backgroundColor = backgroundColor
        // Do any additional setup after loading the view.
    }
    
}

extension ChangeLanguageViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeLanguageTableViewCell") as! ChangeLanguageTableViewCell        
         cell.initCell(item: languages[indexPath.row], setLanguage: setLanguage)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeLanguageTableViewCell") as! ChangeLanguageTableViewCell
        
        switch languages[indexPath.row].name {
        case "Русский":
            delegate?.setLanguage(language: "Русский")
            cell.chooseButton.setBackgroundImage(UIImage(named: "greenButton"), for: .normal)
            dismiss(animated: true, completion: nil)
    Loader().fetch(structData: ClassSetting.self, url: "http://85.119.145.2/api/user/\(id)/setting", httpMethod: HttpMethod.post, parameters: ["language": "rus",                                                              "update_mobile_network": switchSetting?.do_not_call,
                "notification_discount": switchSetting?.notification_discount,
                "do_not_call": switchSetting?.do_not_call], completion: { (data) in
                    
                })
        case "Английский":
            delegate?.setLanguage(language: "Английский")
            cell.chooseButton.setBackgroundImage(UIImage(named: "greenButton"), for: .normal)
            Loader().fetch(structData: ClassSetting.self, url: "http://85.119.145.2/api/user/\(id)/setting", httpMethod: HttpMethod.post, parameters: ["language": "eng",                                                              "update_mobile_network": switchSetting?.do_not_call,
                        "notification_discount": switchSetting?.notification_discount,
                        "do_not_call": switchSetting?.do_not_call], completion: { (data) in
                            
                        })
            dismiss(animated: true, completion: nil)
        default:
            print(languages[indexPath.row].name)
        }
    }
}

