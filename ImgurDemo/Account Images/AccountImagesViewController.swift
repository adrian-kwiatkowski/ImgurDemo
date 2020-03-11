import UIKit
import SnapKit
import RxSwift

class AccountImagesViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    private let coordinator: MainCoordinator
    private let viewModel: AccountImagesViewModel
    private let mainView: AccountImagesView
    private let disposeBag = DisposeBag()
    
    // MARK: - INIT
    
    init(viewModel: AccountImagesViewModel = AccountImagesViewModel(), coordinator: MainCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.mainView = AccountImagesView()
        super.init(nibName: nil, bundle: nil)
        setupUI()
        bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        title = "Imgur Demo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func bindUI() {
        viewModel.images.bind(to: mainView.collectionView.rx.items(cellIdentifier: "ImageCollectionViewCell", cellType: ImageCollectionViewCell.self)) { (_, imageURL, cell) in
            cell.configure(with: imageURL)
        }.disposed(by: disposeBag)
    }
    
    @objc private func addButtonTapped() {
        coordinator.addPhotos(delegate: viewModel)
    }
}
