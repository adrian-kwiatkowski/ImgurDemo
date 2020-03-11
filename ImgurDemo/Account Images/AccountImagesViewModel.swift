import UIKit
import RxRelay

class AccountImagesViewModel: NSObject {
    
    private let networkService: NetworkService
    
    public let images: BehaviorRelay<[URL]> = BehaviorRelay(value: [])
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
        super.init()
        getImages()
    }
    
    func getImages() {
        networkService.fetchImages()
            .done { [weak self] in
                let newImages = $0.data.compactMap { URL(string: $0.link) }
                print("\(newImages.count) images")
                self?.images.accept(newImages)
        }
        .catch { error in
            print(error.localizedDescription)
        }
    }
    
    func upload(_ image: UIImage) {
        networkService.upload(image)
            .done { [weak self] _ in
                self?.getImages()
        }
        .catch { error in
            print(error.localizedDescription)
        }
    }
}

extension AccountImagesViewModel: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let editedImage = info[.editedImage] as? UIImage else { return }
        picker.dismiss(animated: true, completion: { [weak self] in
            self?.upload(editedImage)
        })
    }
}

extension AccountImagesViewModel: UINavigationControllerDelegate {}
