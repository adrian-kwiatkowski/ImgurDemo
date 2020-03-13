import UIKit
import RxRelay

class AccountImagesViewModel: NSObject {
    
    private let networkService: NetworkService
    
    public let images: BehaviorRelay<[ImageData]> = BehaviorRelay(value: [])
    public let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
        super.init()
        getImages()
    }
    
    func getImages() {
        isLoading.accept(true)
        networkService.fetchImages()
            .done { [weak self] in
                self?.isLoading.accept(false)
                print("\($0.data.count) images")
                self?.images.accept($0.data)
        }
        .catch { error in
            print(error.localizedDescription)
        }
    }
    
    func upload(_ image: UIImage) {
        isLoading.accept(true)
        networkService.upload(image)
            .done { [weak self] _ in
                self?.isLoading.accept(false)
                self?.getImages()
        }
        .catch { error in
            print(error.localizedDescription)
        }
    }
    
    func deleteImage(with deleteHash: String) {
        isLoading.accept(true)
        networkService.deleteImage(with: deleteHash)
            .done { [weak self] _ in
                self?.isLoading.accept(false)
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
