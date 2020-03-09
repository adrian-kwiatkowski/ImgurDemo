import UIKit

class MainViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let coordinator: Coordinator
    
    // MARK: - INIT
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
