import UIKit
import MapKit
import Firebase
import FirebaseStorage


class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    
    var locations = [CustomAnnotation]()
    
    var userLocation: CLLocation!
        
    override func viewDidLoad() {
            super.viewDidLoad()
            
        locationManager.requestAlwaysAuthorization()
            locationManager.delegate = self
           locationManager.startUpdatingLocation()
            mapView.userTrackingMode = .follow
            
            
            mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: "marker")
            mapView.delegate = self
        
        
//        let coordinate = CLLocationCoordinate2D(latitude: 50.715739, longitude: -1.875466)
//        let region = CLCircularRegion(center: coordinate, radius: 10, identifier: "Pier")
//        locationManager.startMonitoring(for: region)
        
        loadLocations()
            }
    
    func loadLocations() {
        let ref = Firestore.firestore().collection("locations")
        ref.getDocuments { (snapshot, error) in
            for document in snapshot!.documents {
                let annotation = CustomAnnotation(document: document)
                self.mapView.addAnnotation(annotation)
    
            
            }
    
        }
    }

            
}
    extension ViewController: CLLocationManagerDelegate {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let mostRecent = locations.last else { return }
            userLocation = mostRecent
            
//        }
//
//        func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//            print("Entered: \(region.identifier) region.")
//
//            guard let annotation = locations.first(where: { $0.title! == region.identifier }) else  { return }
//            annotation.selectable = true
//
//        }
//
//        func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//            print("Left: \(region.identifier) region.")
//
//            guard let annotation = locations.first(where: { $0.title! == region.identifier }) else  { return }
//            annotation.selectable = false
        }
        
    }
    
    extension ViewController: MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            mapView.deselectAnnotation(view.annotation, animated: true)
            guard let annoation = view.annotation as? CustomAnnotation else { return }
            
            let distance = userLocation.distance(from: CLLocation(latitude: annoation.coordinate.latitude, longitude: annoation.coordinate.longitude))
                
            if distance < 100 {
            performSegue(withIdentifier: "Next", sender: view.annotation!)
                
            }
            
        }
        
        
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? CustomAnnotation else { return nil }
            let identifier = "marker"
            var view: CustomAnnotationView
        
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? CustomAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
                view.tintColor = annotation.color
            } else {
                view = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            return view
        }
}
        
    extension ViewController: SecondViewControllerDelegate {
            
            func didUpdate(annotation: CustomAnnotation) {
                mapView.removeAnnotation(annotation)
                mapView.addAnnotation(annotation)
            }
            
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let vc = segue.destination as! SecondViewController
                vc.annotation = sender as? CustomAnnotation
            }
        
        
        
        
//        override func viewDidAppear(_ animated: Bool) {
//            createAlert(title: "CONGRATULATIONS", message: "YOU FOUND A CLUE")
//        }
//
//
//        func createAlert (title:String, message:String)
//        {
//            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//            //CREATING ON BUTTON
//
//            alert.addAction(UIAlertAction(title: "GIVE HINT FOR NEXT CLUE", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
//                print( "GIVE HINT FOR NEXT CLUE")
//
//
//            }))
//
//            self.present(alert, animated: true, completion: nil)
//        }
//
    }



