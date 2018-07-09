
import IGListKit


class ColorSectionController : ListSectionController{
    
    

    static let customInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    static let tippingSpace : CGFloat = 50
    var dummyData : Int = 0
    var sectionIndex : Int = 0
    
    override init() {
        super.init()
        inset = ColorSectionController.customInsets
    }
    
    
    override func numberOfItems() -> Int {
        //Definining the Reported cell as cell associated with number 3
        if dummyData == 200000{
            return 1
        }
        return 2
    }
    
    static func getSectionSize() -> CGSize{
        return CGSize(width: getSectionWidth(), height: getSectionHeight())
    }
    
    static func getSectionWidth() -> CGFloat{
        return UIScreen.main.bounds.width - customInsets.left - customInsets.right - tippingSpace
    }
    
    static func getSectionHeight() -> CGFloat{
        return OrangeCollectionViewCell.cellHeight
    }
    
    
    static func getSectionSizeWithInset() -> CGSize{
        return CGSize(width: getSectionWidthWithInset(), height: getSectionHeightWithInset())
    }
    
    static func getSectionWidthWithInset() -> CGFloat{
        return UIScreen.main.bounds.width - tippingSpace
    }
    
    static func getSectionHeightWithInset() -> CGFloat{
        return OrangeCollectionViewCell.cellHeight + customInsets.top + customInsets.bottom
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        
        let colorInfoCellWidth = context.containerSize.width - OrangeCollectionViewCell.cellWidth - ColorSectionController.tippingSpace
        
        if index == 0{
            return CGSize(width: OrangeCollectionViewCell.cellWidth, height: OrangeCollectionViewCell.cellHeight)
        }
        else{
           return CGSize(width: colorInfoCellWidth, height: OrangeCollectionViewCell.cellHeight)
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        switch index{
        case 0:
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "OrangeCollectionViewCell", bundle: nil, for: self, at: index) as? OrangeCollectionViewCell else {return UICollectionViewCell()}
            cell.setLabel(sectionIndex: sectionIndex, cellIndex: index)
            return cell
            
        default:
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "GreenCollectionViewCell", bundle: nil, for: self, at: index) as? GreenCollectionViewCell else {return UICollectionViewCell()}
            cell.setLabel(sectionIndex: sectionIndex, cellIndex: index)
            return cell
        }
        
    }
    
    //This function is used to hand an object to the section controller. Note this method will always be called before any of the cell protocol methods.
    override func didUpdate(to object: Any) {
        guard let dummyInt = object as? Int else { return }
        self.dummyData = dummyInt
    }
    
    override func didSelectItem(at index: Int) {
    }
    
}




