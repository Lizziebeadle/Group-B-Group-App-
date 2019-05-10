import UIKit
import MapKit

protocol SecondViewControllerDelegate {
    func didUpdate(annotation: CustomAnnotation)
}

class SecondViewController: UIViewController {
    
    var annotation: CustomAnnotation!
    var delegate: SecondViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
}

}
