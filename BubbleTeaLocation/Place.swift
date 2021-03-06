import Foundation
import GoogleMaps

class Place {
    let name: String
    let location: CLLocationCoordinate2D
    
    init(venue: Venues) {
//        self.name = venue["name"] as? String ?? ""
        self.name = venue.name
//        let rawLocation = venue["location"] as? [String: Any] ?? [:]
//        let lat = rawLocation["lat"] as? Double ?? 0.0
//        let lng = rawLocation["lng"] as? Double ?? 0.0
        let lat = venue.location.lat
        let lng = venue.location.lng
        self.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}
