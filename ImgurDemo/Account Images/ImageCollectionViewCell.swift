import UIKit
import SnapKit
import AsyncDisplayKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    private let imageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.defaultImage = UIImage(named: "default")
        node.placeholderEnabled = true
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        addSubnode(imageNode)        
        imageNode.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageURL: URL) {
        imageNode.url = imageURL
    }
}
