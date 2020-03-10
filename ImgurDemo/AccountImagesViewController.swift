import UIKit
import SnapKit
import RxSwift

class AccountImagesViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    private let coordinator: Coordinator
    private let viewModel: AccountImagesViewModel
    private let mainView: AccountImagesView
    private let disposeBag = DisposeBag()
    
    // MARK: - INIT
    
    init(viewModel: AccountImagesViewModel = AccountImagesViewModel(), coordinator: Coordinator) {
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
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func bindUI() {
        viewModel.images.bind(to: mainView.collectionView.rx.items(cellIdentifier: "ImageCollectionViewCell", cellType: ImageCollectionViewCell.self)) { (_, image, cell) in
            cell.configure(with: image)
        }.disposed(by: disposeBag)
    }
}
