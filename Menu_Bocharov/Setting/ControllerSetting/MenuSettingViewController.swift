import UIKit


class MenuSettingViewController: UIViewController {
    
    @IBOutlet weak var settingTable: UITableView!
    @IBOutlet weak var headMenuView: UIView!
    
    @IBOutlet weak var titleNavigation: UINavigationItem!
    var settings = Setting.getnames()
    
    var settingsApi: Settings? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headMenuView.backgroundColor = backgroundColor
        
        Loader().fetch(structData: ClassSetting.self, url: "http://85.119.145.2/api/user/\(id)/setting", httpMethod: HttpMethod.get, parameters: nil, completion: { (data) in self.settingsApi = data.data
//                    for i in data.data {
//                        self.settingsApi.append(i)
//                    }
                    print(self.settingsApi)
            self.settings[0].names[2].switchIsOn = data.data.do_not_call
            self.settings[1].names[0].switchIsOn = data.data.notification_discount
            self.settings[2].names[0].switchIsOn = data.data.update_mobile_network
            if self.settingsApi?.language == "rus"{
            self.settings[0].names[0].languageText = "Русский"
            } else{
                self.settings[0].names[0].languageText = "Английский"
            }
            self.settingTable.reloadData()

                    })

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "changeLanduage",
            let vc = segue.destination as? ChangeLanguageViewController,
            let index = settingTable.indexPathForSelectedRow
             {
                vc.setLanguage = settings[index.section].names[index.row].languageText
                vc.switchSetting = settingsApi
                vc.delegate = self
             }
        
         
    if  segue.identifier == "showPersonData",
                let vc = segue.destination as? PersonDataViewController
                 {
                    print("Person data")
  
                 }
             }
}

extension MenuSettingViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settings[section].tittle
    }
    
      func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = backgroundColor
            headerView.textLabel?.textColor = colortitleSection
            headerView.textLabel?.font = UIFont.systemFont(ofSize: 12)
            headerView.textLabel?.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 1.5)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") as! SettingTableViewCell
        
        cell.initCell(item: settings[indexPath.section].names[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //           tableView.deselectRow(at: indexPath, animated: true)
        switch settings[indexPath.section].names[indexPath.row].nameSettring {
        case "Язык":
            self.performSegue(withIdentifier: "changeLanduage", sender: self)
        case "Персональные данные":
            self.performSegue(withIdentifier: "showPersonData", sender: self)
        
        default:
            print(settings[indexPath.section].names[indexPath.row].nameSettring)
        }
               
    }
}


extension MenuSettingViewController: ChangeLanguageProtocol{
    func setLanguage(language: String) {
        settings[0].names[0].languageText = language
        settingTable.reloadData()
    }
    
    
}


extension MenuSettingViewController: SetSwitchSettingDelegate{
    func change(isOn: Bool, name: String) {
        switch name{
            case "Push-уведомления вместо звонка":
                 print("Push-уведомления вместо звонка is \(isOn)")
                 
            settings[0].names[2].switchIsOn = isOn
                 Loader().fetch(structData: ClassSetting.self, url: "http://85.119.145.2/api/user/\(id)/setting", httpMethod: HttpMethod.post, parameters: ["language": settingsApi?.language,
            "update_mobile_network": isOn,
            "notification_discount": settingsApi?.notification_discount,
            "do_not_call": settingsApi?.do_not_call], completion: { (data) in
                      
                self.settingsApi = data.data
//                self.settingTable.reloadData()
                print("New: \(self.settingsApi)")
                
            })
//            send to server
            case "Уведомления об акциях":
                print("Уведомления об акциях is \(isOn)")
                
                 settings[1].names[1].switchIsOn = isOn
    Loader().fetch(structData: ClassSetting.self, url: "http://85.119.145.2/api/user/\(id)/setting", httpMethod: HttpMethod.post, parameters: ["language": settingsApi?.language,
                                                                                                                                               "update_mobile_network": settingsApi?.do_not_call,
    "notification_discount": isOn,
    "do_not_call": settingsApi?.do_not_call], completion: { (data) in
              
        self.settingsApi = data.data
//        self.settingTable.reloadData()
        print("New: \(self.settingsApi)")
        
    })
                //            send to server
           
            case "Обновлять по сотовой сети":
                print("Уведомления об акциях is \(isOn)")
                //            send to server
            settings[2].names[0].switchIsOn = isOn
            
           
                          Loader().fetch(structData: ClassSetting.self, url: "http://85.119.145.2/api/user/\(id)/setting", httpMethod: HttpMethod.post, parameters: ["language": settingsApi?.language,
                                                                                                                                                                     "update_mobile_network": settingsApi?.do_not_call,
                     "notification_discount": settingsApi?.notification_discount,
                     "do_not_call": isOn], completion: { (data) in
                               
                         self.settingsApi = data.data
//                         self.settingTable.reloadData()
                         print("New: \(self.settingsApi)")
                         
                     })
        
        default:
            print("No")
        }
    }
    
    
}
