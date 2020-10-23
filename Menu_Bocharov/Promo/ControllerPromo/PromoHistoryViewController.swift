//
//  PromoHistoryViewController.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 27.08.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class PromoHistoryViewController: UIViewController {
    

    
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var segmentPromo: UISegmentedControl!
    @IBOutlet weak var tableHistoryPromo: UITableView!


    
       var promoCodes: [Promos] = []
    var promosForTable = [Promos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.text = "История использования"

        
        view.backgroundColor = backgroundColor
        tableHistoryPromo.backgroundColor = backgroundColor
        
        Loader().fetch(structData: DataPromo.self, url: "http://85.119.145.2/api/user/\(id)/promo-codes", httpMethod: HttpMethod.get, parameters: nil, completion: { (data) in
                    for i in data.data {
                        self.promoCodes.append(i)
                    }
                    print(self.promoCodes)
            self.tableHistoryPromo.reloadData()
  
                    })
        
        
    }
    

    @IBAction func reloadTable(_ sender: Any) {
        switch(segmentPromo.selectedSegmentIndex)
           {
           case 0:
               tableHistoryPromo.reloadData()
               break

           case 1:
               tableHistoryPromo.reloadData()
               break
           default:
               break

           }
    }
}

extension PromoHistoryViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if segmentPromo.selectedSegmentIndex == 0{
            promosForTable = promoCodes.filter{
                ($0.used == false)
            }
            descriptionView.text = "Обращаем ваше внимание, что скидки по промокодам на аналогичные сервисы не суммируются. На ближайший заказ сработает тот промокод, срок действия которого истекает раньше."
            descriptionView.textColor = UIColor(hexString: "#8A8A8D", alpha: 1)
            descriptionView.isHidden = false
            return promosForTable.count
        } else {
            promosForTable = promoCodes.filter{
                ($0.used == true)
            }
            descriptionView.text = ""
            descriptionView.isHidden = true
            return promosForTable.count
        }
        
        
      }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryPromoTableViewCell") as! HistoryPromoTableViewCell
        cell.initCell(item: promosForTable[indexPath.row])
        
        cell.mainView.layer.cornerRadius = 15
        cell.downView.backgroundColor = UIColor(hexString: "#EEEEEE", alpha: 1)
        cell.contentView.backgroundColor = backgroundColor
        cell.viewBottom.backgroundColor = backgroundColor
        cell.upView.backgroundColor =  .white
//        cell.mainView.backgroundColor = UIColor(patternImage: UIImage(named: "Rectangle 57")!)

        return cell
    }
    
    
               
    }

