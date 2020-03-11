import UIKit
import SnapKit

class ImageCollectionViewCell: UICollectionViewCell {
        
    private let imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        clipsToBounds = true
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageURL: String) {
        imageView.image = UIImage(named: "default")
        print(imageURL)
    }
}
