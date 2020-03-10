import UIKit
import RxRelay

class AccountImagesViewModel: NSObject {
    
    public let images: BehaviorRelay<[UIImage]> = BehaviorRelay(value: [])
    
    override init() {
        super.init()
        requestData()
    }

    public func requestData() {
        if let image = UIImage(named: "default") {
            images.accept([image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image])
        }
    }
}

extension AccountImagesViewModel: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        print(image.size)
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AccountImagesViewModel: UINavigationControllerDelegate {
    
}
