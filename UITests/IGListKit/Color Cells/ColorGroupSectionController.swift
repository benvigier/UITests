import IGListKit



class ColorGroupSectionController: ListSectionController{
    
    static let customInsets = UIEdgeInsets(top: 5, left: 0, bottom: 20, right: 0)
    var numberOfRows = 2
    var dummyData = [Int]()
    
    
    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    override init() {
        super.init()
        inset = ColorGroupSectionController.customInsets
    }
    
    func calculateHeight() -> CGFloat{
        let cellCount = dummyData.count
        
        if cellCount < numberOfRows{
            return CGFloat(cellCount) * ColorSectionController.getSectionHeightWithInset()
        }
        return ColorSectionController.getSectionHeightWithInset() * CGFloat(numberOfRows)
    }
    
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else {return .zero}
        let width = context.containerSize.width
        let height = calculateHeight()
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: EmbeddedCollectionViewCell.self, for: self, at: index) as? EmbeddedCollectionViewCell else {return UICollectionViewCell()}
        adapter.collectionView = cell.collectionView
        let layout = ListCollectionViewLayout(stickyHeaders: false, scrollDirection: .horizontal, topContentInset: 0.0, stretchToEdge: false)
        adapter.collectionView?.setCollectionViewLayout(layout, animated: true)
        adapter.collectionView?.reloadData() ////Needed to avoid crash: https://github.com/Instagram/IGListKit/issues/952
        
        return cell
    }
    
    
    override func didUpdate(to object: Any) {
    }
    
    override func didSelectItem(at index: Int) {
    }
}


extension ColorGroupSectionController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return dummyData as [ListDiffable]
    }
    
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let colorCellSection = ColorSectionController()
        
        if let dummyInt = object as? Int{
            colorCellSection.dummyData = dummyInt
            let index = dummyData.index(of: dummyInt)
            if let idx = index{
                colorCellSection.sectionIndex = idx
            }
            
        }
        return colorCellSection
    }
    
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
