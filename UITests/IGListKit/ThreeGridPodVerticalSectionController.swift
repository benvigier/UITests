//
//  SmallPodCollectionHorizontalSectionController.swift
//  UITests
//
//  Created by Benjamin Vigier on 6/4/18.
//  Copyright © 2018 Benjamin Vigier. All rights reserved.
//

import IGListKit

protocol ThreeGridPodVerticalSectionControllerDelegate {
    func didTapThreeGridVerticalPodCell(conversation: Conversation)
}


//This section has a single cell: an Embedded Cell that is an horizontal collection view
class ThreeGridPodVerticalSectionController: ListSectionController{
    
    var delegate: ThreeGridPodVerticalSectionControllerDelegate?
    var conversations: [Conversation]?
    
    //Space between this section and the next
    static let customInsets = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
    
    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    override init() {
        super.init()
        //Space between this section and the next
        inset = ThreeGridPodVerticalSectionController.customInsets
    }
    
    func calculateHeight() -> CGFloat{
        
        guard let conversationData = conversations else {return 0}
        var rows = floor(CGFloat(conversationData.count) / 3)
        if conversationData.count % 3 != 0{
            rows += 1
        }
        print("ROWS = ", rows)
        let height = CGFloat(rows) * ThreeGridPodSectionController.getHeight()
        return height + ThreeGridPodVerticalSectionController.customInsets.top + ThreeGridPodVerticalSectionController.customInsets.bottom
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
        guard let cell = collectionContext?.dequeueReusableCell(of: VerticalEmbeddedCollectionViewCell.self, for: self, at: index) as? VerticalEmbeddedCollectionViewCell else {return UICollectionViewCell()}
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    //This function is used to hand an object to the section controller. Note this method will always be called before any of the cell protocol methods.
    override func didUpdate(to object: Any) {
        if let conversations = object as? [Conversation]{
            self.conversations = conversations
        }
    }
    
    override func didSelectItem(at index: Int) {
        //Create a delegate and call it here if adding another cell to that controller: e.g., View All
       print("Did tap the Three Pod Vertical Pod cell")
    }
}


extension ThreeGridPodVerticalSectionController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        //Add some code here to return somethiong if conversations is nil
        return conversations! as [ListDiffable]
    }
    
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if object is Conversation{
            let threeGridPodSectionController = ThreeGridPodSectionController()
            threeGridPodSectionController.delegate = self
            threeGridPodSectionController.conversation = object as! Conversation
            
            //Removing the right inset if this section is at the end of a row
            guard let index = conversations?.index(of: object as! Conversation) else {return threeGridPodSectionController}
            if (index + 1) % 3 == 0 {
               threeGridPodSectionController.inset.right = 0
            }
           
            return threeGridPodSectionController
        }
       //Should never happen at this point - Update by returning a different type of section controller there's nothing
        return ThreeGridPodSectionController()
    }
    
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension ThreeGridPodVerticalSectionController: ThreeGridPodSectionControllerDelegate{
    func didTapCell(conversation: Conversation) {
         delegate?.didTapThreeGridVerticalPodCell(conversation: conversation)
    }

}
