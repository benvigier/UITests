import IGListKit

protocol FeedSeparatorSectionControllerDelegate {
    func didTapViewAll()
}


class FeedSeparatorSectionController : ListSectionController{
    
   
    var title: String?
    var isButtonHidden = false
    static let customInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    
    override init() {
        super.init()
        inset = FeedSeparatorSectionController.customInsets
    }
    
    static func getHeight() -> CGFloat {
        return FeedSeparatorCollectionViewCell.getCellHeight()
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else {return .zero}
        let height = FeedSeparatorCollectionViewCell.getCellHeight()
        let width = context.containerSize.width
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "FeedSeparatorCollectionViewCell", bundle: nil, for: self, at: index) as? FeedSeparatorCollectionViewCell else {return UICollectionViewCell()}
        
        if let text = self.title{
            cell.setTitle(title: text)
        }
        cell.isButtonHidden(self.isButtonHidden)
        return cell
    }
    
    override func didUpdate(to object: Any) {
    }
    
    override func didSelectItem(at index: Int) {
    }
    
}


