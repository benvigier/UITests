//
//  ThreeGridPodCollectionSectionController.swift
//  UITests
//
//  Created by Benjamin Vigier on 6/4/18.
//  Copyright © 2018 Benjamin Vigier. All rights reserved.
//

import IGListKit

protocol ThreeGridPodCollectionSectionControllerDelegate {
    func didTapThreeGridPodCell(conversation: Conversation)
}


//This section has a single cell: an Embedded Cell that is an horizontal collection view
class ThreeGridPodCollectionSectionController: ListSectionController{
    
    var delegate: ThreeGridPodCollectionSectionControllerDelegate?
    var conversations: [Conversation]?
    
    //Space between this section and the next
    let customInsets = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
    
    override init() {
        super.init()
        //Space between this section and the next
        inset = customInsets
        //Vertical space between the pods in this collection
        minimumLineSpacing = 5
        //Horizontal space between the pods in this collection
        minimumInteritemSpacing = 5
    }
    
    override func numberOfItems() -> Int {
        guard let conversationData = self.conversations else {return 0}
        return conversationData.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        let width = ThreeGridPodCollectionViewCell.cellWidth()
       // let width = context.containerSize.width / 3 //TODO: prendre en compte les insets des pods section controllers
        let height = ThreeGridPodCollectionViewCell.cellHeight()
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let conversationData = self.conversations else {return UICollectionViewCell()}
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ThreeGridPodCollectionViewCell", bundle: nil, for: self, at: index) as? ThreeGridPodCollectionViewCell else {return UICollectionViewCell()}
        cell.conversation = conversationData[index]
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
        guard let conversationData = self.conversations else {return}
        delegate?.didTapThreeGridPodCell(conversation: conversationData[index])
    }
}
