import IGListKit

protocol CarSectionControllerDelegate {
    func didTapCarSectionController(car: Car)
}


class CarSectionController : ListSectionController{
    
    var car: Car!
    var delegate: CarSectionControllerDelegate?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else {return .zero}
        
        let height = CarCollectionViewCell.cellHeight(image: car.photo, forWidth: context.containerSize.width)
        return CGSize(width: context.containerSize.width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        if let cell = collectionContext?.dequeueReusableCell(withNibName: "CarCollectionViewCell", bundle: nil, for: self, at: index) as? CarCollectionViewCell{
            cell.car = car
            return cell
        }
        let cell = CarCollectionViewCell()
        cell.car = car
        return cell
    }
    

    override func didUpdate(to object: Any) {
        if let car = object as? Car{
            self.car = car
        }
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.didTapCarSectionController(car: car)
    }
    
}

