import Foundation

class CarSectionToken: NSObject{
    var id = 0
}

class ColorTitleSectionToken: NSObject{
    var id = 0
}


class ColorGroupSectionToken: NSObject{
    var id = 0
    var colorData : [Int]
    
    init(colorData: [Int]){
        self.colorData = colorData
    }
    
    //Overriding to allow IGListKit to properly diff and only update the section when needed
    override func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let sectionToken = object as? ColorGroupSectionToken else {return false}
        
        if sectionToken.colorData.count != self.colorData.count{
            return false
        }
        
        
        //If both are empty, return true
        if colorData.isEmpty{
            return true
        }
        
        return sectionToken.colorData.elementsEqual(colorData) {
            $0 == $1
        }
    }
    
}


class CarsTitleSectionToken: NSObject{
    var id = 0
}


