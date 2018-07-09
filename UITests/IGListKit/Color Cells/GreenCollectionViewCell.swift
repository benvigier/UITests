
import UIKit

class GreenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLabel(sectionIndex: Int, cellIndex: Int){
        titleLabel.text = "Sec \(sectionIndex) | Cell \(cellIndex)"
    }
    
}
