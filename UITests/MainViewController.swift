import UIKit
import IGListKit

class MainViewController: UIViewController {
    
    var colorGroupSectionToken : ColorGroupSectionToken?
    var colorSectionData = [1,2,3,4,5,6,7,8,9,10]
    
    var collectionViewData : [Car]?
    var customInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    
    let collectionView : UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        collectionView.register(UINib(nibName: "CarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarCollectionViewCell")
        collectionView.contentInset = customInsets
        collectionView.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        adapter.collectionView = collectionView
        adapter.dataSource = self
        view.addSubview(collectionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        let layout: ListCollectionViewLayout = ListCollectionViewLayout(stickyHeaders: false, scrollDirection: .vertical, topContentInset: 50, stretchToEdge: false)
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    func loadData(){
        let car1 = Car(brand: .bmw, model: "128i", color: "Black", photo: UIImage(imageLiteralResourceName: "bmw"), logo: UIImage(imageLiteralResourceName: "bmwlogo"))
        let car2 = Car(brand: .bmw, model: "Prototype", color: "Grey", photo: UIImage(imageLiteralResourceName: "bmw2"), logo: UIImage(imageLiteralResourceName: "bmwlogo"))
        let car3 = Car(brand: .porsche, model: "911 Carrera", color: "Night Blue", photo: UIImage(imageLiteralResourceName: "porsche"), logo: UIImage(imageLiteralResourceName: "porschelogo"))
        let car4 = Car(brand: .astonmartin, model: "Vintage", color: "Dark Grey", photo: UIImage(imageLiteralResourceName: "astonmartin"),logo: UIImage(imageLiteralResourceName: "astonmartinlogo"))
        let car5 = Car(brand: .audi, model: "S5", color: "Black", photo: UIImage(imageLiteralResourceName: "audi"),logo: UIImage(imageLiteralResourceName: "audilogo"))
        
        collectionViewData = [Car]()
        collectionViewData!.append(car1)
        collectionViewData!.append(car3)
        collectionViewData!.append(car4)
        collectionViewData!.append(car5)
        collectionViewData!.append(car2)
    }
    
    func updateColorSection(){
        guard let token = self.colorGroupSectionToken, let section = adapter.sectionController(for: token) as? ColorGroupSectionController else {return}
        section.dummyData = self.colorSectionData
        section.adapter.performUpdates(animated: true, completion: nil)
    }
    
    
}


extension MainViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        var objects = [ListDiffable]()
        objects.append(ColorTitleSectionToken() as ListDiffable)
        
        self.colorGroupSectionToken = ColorGroupSectionToken(colorData: self.colorSectionData)
        if let token = self.colorGroupSectionToken{
            objects.append(token as ListDiffable)
        }
        
        objects.append(CarsTitleSectionToken() as ListDiffable)
        objects += collectionViewData! as [ListDiffable]
        
        return objects
    }
    
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if object is ColorTitleSectionToken{
            let feedSeparatorSectionController = FeedSeparatorSectionController()
            feedSeparatorSectionController.title = "SECTION WITH LAYOUT ISSUE"
            return feedSeparatorSectionController
        }
        
        if object is ColorGroupSectionToken{
            let colorGroupSection = ColorGroupSectionController()
            colorGroupSection.dummyData = self.colorSectionData
            return colorGroupSection
        }
        
        
        if object is CarsTitleSectionToken{
            let feedSeparatorSectionController = FeedSeparatorSectionController()
            feedSeparatorSectionController.title = "SOME CARS"
            feedSeparatorSectionController.isButtonHidden = true
            return feedSeparatorSectionController
        }
        
        let carSectionController = CarSectionController()
        carSectionController.car = object as! Car
        carSectionController.delegate = self
        return carSectionController
    }
    
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}






extension MainViewController: CarSectionControllerDelegate{
    
    func didTapCarSectionController(car: Car) {
        print("MAIN VIEW CONTROLLER - DID TAP CAR")
    }
}





