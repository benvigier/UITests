
import UIKit

class OrangeCollectionViewCell: UICollectionViewCell {
    static let cellWidth : CGFloat = 70
    static let cellHeight : CGFloat = 70
    
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var colorImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLabel(sectionIndex: Int, cellIndex: Int){
        sectionLabel.text = "Sec \(sectionIndex)"
        cellLabel.text = "Cell \(cellIndex)"
    }
}
