import GoogleMaps
import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 13.8402667, longitude: 100.5892565))
        
        marker.map = mapView
    }
    
    @IBAction func findAction(_ sender: Any) {
        Alamofire.request("https://api.foursquare.com/v2/venues/search?client_id=QEXTWH4CSXYI3MVGMGQLMSDCE3T04FLIB431BJEI5EL033PA&client_secret=2SXJ0I0H3EHM5C2NJYEVIDRYHWGEDG4YZOV4Y55OKWHOTKQX&v=20180323&limit=10&ll=\(locationManager.location?.coordinate.latitude ?? 0.0),\(locationManager.location?.coordinate.longitude ?? 0.0)&query=bubbletea")
            .responseJSON(completionHandler: {res in
                guard let json = res.result.value as? [String: Any] else {
                    return
                }
                
                guard let response = json["response"] as? [String: Any] else {
                    return
                }
                
                guard let venues = response["venues"] as? [[String: Any]] else {
                    return
                }
                
                print(venues)
                
                venues.forEach {venue in
                    let place = Place(venue: venue)
                    print(place.name)
                    let marker = GMSMarker(position: place.location)
                    marker.map = self.mapView
                    marker.title = place.name
                }
            })
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status.rawValue)
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //If locations.first null, return. If locations.first not null, add value to location
        guard let location = locations.first else {
            return
        }
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
        mapView.camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
    }
}
