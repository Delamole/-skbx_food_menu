

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON


class FoodMainViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var vertView: UIView!
    @IBOutlet weak var secondHorView: UIView!
    @IBOutlet weak var firstHorView: UIView!
    @IBOutlet weak var acceptButton: AcceptButton!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressTable: UITableView!
    
    var keyboardHeight: CGFloat = 0
    var adresses: [Adres] = []
    var index = 0
    var nameAdress = ""
   
    let geocoder = GMSGeocoder()
    let locationManager = LocationManager.shared
    var markers: [GMSMarker] = []
    
    @IBAction func enterAdress(_ sender: Any) {
        if addressTextField.text != ""{
            acceptButton.backgroundColor = activButtonColor
            acceptButton.isEnabled = true
        }
    }
    
    @IBAction func show_point_address(_ sender: Any) {
        getAddress(address: addressTextField.text!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nameAdress = ""
        addressTextField.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "showShop",
        let vc = segue.destination as? ShopViewController
         {
            vc.name = nameAdress
            vc.descr = addressTextField.text ?? ""
            myBasket.to = addressTextField.text ?? ""
            myBasket.nameAdr = "\(adresses[index].name)"
         }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        addressTextField.resignFirstResponder()
        
        mainView.isHidden = false
        mainView.layer.cornerRadius = 15
        acceptButton.backgroundColor = unActivButtonColor
        vertView.backgroundColor = unActivButtonColor
        firstHorView.backgroundColor = horViewForAddress
        secondHorView.backgroundColor = unActivButtonColor
//        acceptButton.isEnabled = false
        LoadModel.shared.loadAddress{ (data) in
            for i in data.data {
                self.adresses.append(i)
            }
            self.addressTable.reloadData()
        }
        
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        locationManager.requestAccess { (isAccess) in
            if isAccess {
                self.locationManager.getLocation(completition: { (loction) in
                    
                    if nil != loction {
                                                
                        self.mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: loction!.latitude, longitude: loction!.longitude), zoom: 18.0)
                        
                    }
                    
                })
            }
        }
    }
    
    @IBAction func acceptAction(_ sender: Any) {
//        myBasket.to = addressTextField.text ?? ""
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.bottomConstraint.constant = 0
                     },
                         completion:{ finished in
                           print("View is showed")
                })
    }
    
    @IBAction func showMap1(_ sender: Any) {
         mainView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         mainView.isHidden = false
    }

    
      @objc func keyboardDidShow(_ notification: Notification) {
            keyboardHeight = (notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as! CGRect).height
           self.bottomConstraint.constant = -5
            
            print("var keyboardHeight: \(keyboardHeight)")
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.bottomConstraint.constant -= self.keyboardHeight
                print("var bottomConstraint: \(self.bottomConstraint)")
                         },
                             completion:{ finished in
                               print("View is showed")
                    })
      
        }
    
    private func createGMSMarker(
        latitude lat:CLLocationDegrees,
        longitude lon:CLLocationDegrees,
        title:String, snippet:String
    ) -> GMSMarker {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lon))
        marker.title = title
        marker.snippet = snippet
        marker.map = mapView
        
        return marker
    }
    func getAddress(address:String){

    let key : String = "AIzaSyCErxqNemLERT8DHtMI4E3PdV2vCy9spKE"
    let postParameters:[String: Any] = [ "address": address,"key":key]
    let url : String = "https://maps.googleapis.com/maps/api/geocode/json"

    AF.request(url, method: .get, parameters: postParameters, encoding: URLEncoding.default, headers: nil).responseJSON {  response in
        
        switch response.result {
                    case .success(let value):
                        let receivedResults = value
                            let resultParams = JSON(receivedResults)
                            print(resultParams) // RESULT JSON
                            print(resultParams["status"]) // OK, ERROR
                        let lat = resultParams["results"][0]["geometry"]["location"]["lat"].doubleValue
                            print(lat) // approximately latitude
                        let lon = resultParams["results"][0]["geometry"]["location"]["lng"].doubleValue
                            print(lon) // approximately longitude
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        marker.title = "Ваш адрес"
                        marker.snippet = "Доставить сюда"
                        marker.map = self.mapView
                        
                    case .failure(let error):
                        print(error)
                    }
    }
}
    
    }


extension FoodMainViewController: UITableViewDataSource, UITableViewDelegate{
    

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return adresses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "AddressForFoodTableViewCell") as! AddressForFoodTableViewCell

        cell.initCell(item: adresses[indexPath.row])
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        addressTextField.text = adresses[indexPath.row].address
        nameAdress = adresses[indexPath.row].name
        acceptButton.backgroundColor = activButtonColor
        acceptButton.isEnabled = true
        index = indexPath.row
        
       getAddress(address: adresses[indexPath.row].address)
        
    }
    
  
}






extension FoodMainViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("marker: \(String(describing: marker.title))")
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        print("didTap overlay")
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("didTapAt: \(coordinate)")
        
        geocoder.reverseGeocodeCoordinate(coordinate) { (r, e) in
            if let response = r, let fr = response.firstResult() {
                
                if let thoroughfare = fr.thoroughfare {
                    self.addressTextField.text = thoroughfare
                    self.acceptButton.backgroundColor = activButtonColor
                    self.acceptButton.isEnabled = true
                    self.mainView.isHidden = false
                }
            }
        }
        
        if let first = markers.first {
            first.map = nil
            markers.removeLast()
        }
        
        markers.append(createGMSMarker(latitude: coordinate.latitude, longitude: coordinate.longitude, title:"Chad 5", snippet:"25 25"))
    }
}
