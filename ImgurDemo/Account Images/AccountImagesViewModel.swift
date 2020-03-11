import UIKit
import RxRelay

class AccountImagesViewModel: NSObject {
    
    private let networkService: NetworkService
    
    public let images: BehaviorRelay<[UIImage]> = BehaviorRelay(value: [])
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
        super.init()
        getImages()
    }
    
    func getImages() {
        networkService.fetchImages()
            .done { [weak self] in
                let newImages = $0.data.map { $0.link }
                print(newImages)
                if let image = UIImage(named: "default") {
                    self?.images.accept([image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image])
                }
        }
        .catch { error in
            print(error.localizedDescription)
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
