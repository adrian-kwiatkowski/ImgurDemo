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
        viewModel.images.bind(to: mainView.collectionView.rx.items(cellIdentifier: "ImageCollectionViewCell", cellType: ImageCollectionViewCell.self)) { (_, imageData, cell) in
            cell.configure(with: imageData)
        }.disposed(by: disposeBag)
        
        mainView.collectionView.rx.modelSelected(ImageData.self)
            .subscribe(onNext: { [weak self] in
                self?.deletePhoto(with: $0.deletehash)
            }).disposed(by: disposeBag)
        
        viewModel.isLoading.subscribe(onNext: { [weak self] in
            self?.mainView.loaderView.isHidden = !$0
            self?.navigationItem.rightBarButtonItem?.isEnabled = !$0
        }).disposed(by: disposeBag)
    }
    
    @objc private func addButtonTapped() {
        coordinator.addPhotos(delegate: viewModel)
    }
    
    private func deletePhoto(with deleteHash: String) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Delete photo", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteImage(with: deleteHash)
        }

        alertController.addAction(libraryAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
}
