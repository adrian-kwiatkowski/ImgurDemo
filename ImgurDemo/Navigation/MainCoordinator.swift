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
}
