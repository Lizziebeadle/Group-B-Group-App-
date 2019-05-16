import MapKit
import Firebase

class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var desc: String?
    var color: UIColor!
    var selectable = false
    
    init(document: DocumentSnapshot) {
     let data = document.data()!
     title = data["name"] as? String
     desc = data["desc"] as? String

        
     let geoPoint = data["coordinates"] as! GeoPoint
     coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
    
    }
    
}
