import UIKit
import MapKit
import Firebase
import FirebaseStorage

protocol SecondViewControllerDelegate {
    func didUpdate(annotation: CustomAnnotation)
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var annotation: CustomAnnotation!
    var delegate: SecondViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = annotation.title!
        imageView.image = UIImage(named: annotation.title!)
}
//    let storage = Storage.storage()
//    let storageRef = storage.reference()
//
//    let imagesRef = StorageReference.child("images")
//    var spaceRef = StorageReference.child("images/space.jpg")
//
//    let storagePath = "\(images)/images/space.jpg"
//    spaceRef = storage.reference(forURL: storagePath)
//
//    let localFile = URL(string: "path/to/image")
//    let riversRef = StorageReference.child("images/rivers.jpg")
//    let uploadTask = riversRef.putFile(from: localFile, metadata: nil) {metadata, error in guard let metadata = metadata else {
//        }
//    let size = metadata.size
//        storageRef.downloadURL { (url, error) in guard let downloadURL = url else {
//            }
//            }
//
//        }
//
}
