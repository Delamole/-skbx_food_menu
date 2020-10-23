import UIKit

class PromoViewController: UIViewController {
    
    var promos: [Promo] = [Promo(name: "Ввести промокод"),
                           Promo(name: "История использования")
       ]
 
    
    @IBOutlet weak var promoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "addPromo",
            let vc = segue.destination as? AddPromoViewController,
            let index = promoTable.indexPathForSelectedRow
               {
                }
        if  segue.identifier == "promoHistory",
            let vc = segue.destination as? PromoHistoryViewController,
            let index = promoTable.indexPathForSelectedRow
        {
                }
    }

}

extension PromoViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return promos.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PromoTableViewCell") as! PromoTableViewCell
        cell.initCell(item: promos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //           tableView.deselectRow(at: indexPath, animated: true)
        switch promos[indexPath.row].name {
        case "Ввести промокод":
            self.performSegue(withIdentifier: "addPromo", sender: self)
        case "История использования":
            self.performSegue(withIdentifier: "promoHistory", sender: self)
        
        default:
            print(promos[indexPath.row].name)
        }
               
    }
}
