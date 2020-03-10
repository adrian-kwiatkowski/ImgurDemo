import UIKit

class MainCoordinator: Coordinator {
    
    internal var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
    }

    func start() {
        let viewController = AccountImagesViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showError(with text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        navigationController.present(alert, animated: true)
    }
    
    func addPhotos(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Add photo from library", style: .default) { [weak self] _ in
            self?.photoLibrary(delegate: delegate)
        }

        alertController.addAction(libraryAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        navigationController.present(alertController, animated: true)
    }
    
    func photoLibrary(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = delegate
                pickerController.allowsEditing = true
                pickerController.mediaTypes = ["public.image"]
                pickerController.sourceType = .photoLibrary
        navigationController.present(pickerController, animated: true)
    }
}
