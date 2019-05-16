import UIKit
import MapKit
import Firebase

protocol SecondViewControllerDelegate {
    func didUpdate(annotation: CustomAnnotation)
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var annotation: CustomAnnotation!
    var delegate: SecondViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = annotation.title!
        descLabel.text = annotation.desc!
        imageView.image = UIImage(named: annotation.title!)

    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        UIImagePickerController.SourceType.camera
//
////        self.present(UIImagePickerController, animated: true, completion: nil)
//
//
//        let uuid = UUID().uuidString
//        let image = UIImage(named: "test")!
//        let storageRef = Storage.storage().reference().child(uuid)
//        var sourceType: UIImagePickerController.SourceType
//        var allowsEditing: Bool = true
//
//
//
//
//        let data = image.jpegData(compressionQuality: 0.2)!
//
//        let meta = StorageMetadata()
//        meta.contentType = "image/jpeg"
//
//        storageRef.putData(data, metadata: meta) { meta, error in
//            print(error.debugDescription)
//
//            func imagePicker(){
//                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//
//                }
//
//                class UIPopoverPresentationController : UIPresentationController{
//
//
//                }
//
//
    
        }
    
            
            
        


//public protocol ImagePickerDelegate: class {
//    func didSelect(image: UIImage?)
//}
//open class ImagePicker: NSObject {
//    private let pickerController: UIImagePickerController
//    private weak var presentationController: UIViewController?
//    private weak var delegate: ImagePickerDelegate?
//
//    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
//        self.pickerController = UIImagePickerController()
//
//        super.init()
//
//        self.presentationController = presentationController
//        self.delegate = delegate
//
//        self.pickerController.delegate = self
//        self.pickerController.delegate = true
//        self.pickerController.mediaTypes = ["public.image"]
//
//    }
//
//    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction

//func loadInformation() {
//    let ref = Firestore.firestore().collection("information")
//    ref.getDocuments { (snapshot, error) in
//        for document in snapshot!.documents {
////            let textView = UITextView (document: document)
//        }
//    }
//}

