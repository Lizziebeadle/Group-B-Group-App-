import UIKit
import MapKit

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    
    var locations = [CustomAnnotation]()
        
    override func viewDidLoad() {
            super.viewDidLoad()
            
        locationManager.requestAlwaysAuthorization()
            locationManager.delegate = self
           locationManager.startUpdatingLocation()
            mapView.userTrackingMode = .follow
            
            
            mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: "marker")
            mapView.delegate = self
            
            let firstCoordinate = CLLocationCoordinate2D(latitude: 50.718062, longitude:  -1.866536)
            let firstAnnotation = CustomAnnotation(coordinate: firstCoordinate, title: "Clue 1")
            locations.append(firstAnnotation)
            
            
            let secondCoordinate = CLLocationCoordinate2D(latitude: 50.7138, longitude:  -1.8745)
            let secondAnnotation = CustomAnnotation(coordinate: secondCoordinate, title: "Clue 2")
            locations.append(secondAnnotation)
            
            let thirdCoordinate = CLLocationCoordinate2D(latitude: 50.718003, longitude:  -1.874715)
            let thirdAnnotation = CustomAnnotation(coordinate: thirdCoordinate, title: "Clue 3")
            locations.append(thirdAnnotation)
        
            let forthCoordinate = CLLocationCoordinate2D(latitude: 50.719107, longitude:  -1.878113)
            let forthAnnotation = CustomAnnotation(coordinate: forthCoordinate, title: "Clue 4")
            locations.append(forthAnnotation)
        
            let fifthCoordinate = CLLocationCoordinate2D(latitude: 50.717685, longitude:  -1.870476)
            let fifthAnnotation = CustomAnnotation(coordinate: fifthCoordinate, title: "Clue 5")
            locations.append(fifthAnnotation)
            
            
            
            for location in locations {
                locationManager.startMonitoring(for: location.region)
                mapView.addAnnotation(location)
            }
            
            mapView.showAnnotations(locations, animated: false)
            
            
            
        }
        
    }
    
    extension ViewController: CLLocationManagerDelegate {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        }
        
        func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
            print("Entered: \(region.identifier) region.")
            
            guard let annotation = locations.first(where: { $0.title! == region.identifier }) else  { return }
            annotation.selectable = true
            
        }
        
        func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
            print("Left: \(region.identifier) region.")
            
            guard let annotation = locations.first(where: { $0.title! == region.identifier }) else  { return }
            annotation.selectable = false
        }
        
    }
    
    extension ViewController: MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            mapView.deselectAnnotation(view.annotation, animated: true)
            guard let annoation = view.annotation as? CustomAnnotation else { return }
            if annoation.selectable {
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
        
        
        
        
        override func viewDidAppear(_ animated: Bool) {
            createAlert(title: "CONGRATULATIONS", message: "YOU FOUND A CLUE")
        }
        
        
        func createAlert (title:String, message:String)
        {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            //CREATING ON BUTTON
            
            alert.addAction(UIAlertAction(title: "GIVE HINT FOR NEXT CLUE", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
                print( "GIVE HINT FOR NEXT CLUE")
            
          
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
