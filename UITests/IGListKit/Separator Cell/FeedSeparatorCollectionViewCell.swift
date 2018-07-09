import UIKit

class FeedSeparatorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTitle(title: String){
        label.text = title
    }
    
    func isButtonHidden(_ hideButton : Bool ){
    }
    
    static func getCellHeight() -> CGFloat{
        return 30
    }

}
