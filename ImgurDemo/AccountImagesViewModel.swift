import UIKit
import RxRelay

struct AccountImagesViewModel {
    
    public let images: BehaviorRelay<[UIImage]> = BehaviorRelay(value: [])
    
    init() {
        requestData()
    }

    public func requestData() {
        if let image = UIImage(named: "default") {
            images.accept([image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image, image])
        }
    }
}
