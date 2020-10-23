
import Foundation
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    typealias AccessRequestBlock = (Bool) -> ()
    typealias LocationRequestBlock = (CLLocationCoordinate2D?) -> ()
    
    var isEnabled: Bool { return CLLocationManager.isEnabled }
    var canRequestAccess: Bool { return CLLocationManager.canRequestService }
    
    private var accessRequestCompletition: AccessRequestBlock?
    private var locationRequestCompletition: LocationRequestBlock?
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestAccess(completition: AccessRequestBlock?) {
        accessRequestCompletition = completition
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocation(completition: LocationRequestBlock?) {
        locationRequestCompletition = completition
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
        accessRequestCompletition?(isEnabled)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        locationRequestCompletition?(location)
        locationRequestCompletition = nil
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        locationRequestCompletition?(nil)
        locationRequestCompletition = nil
    }
}

extension CLLocationManager {
    static var canRequestService: Bool {
        return authorizationStatus() != .restricted && authorizationStatus() != .denied
    }
    
    static var isEnabled: Bool {
        return authorizationStatus() == .authorizedAlways || authorizationStatus() == .authorizedWhenInUse
    }
}
