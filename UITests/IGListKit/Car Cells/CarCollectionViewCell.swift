import IGListKit

class CarCollectionViewCell: UICollectionViewCell{
    
    
    @IBOutlet weak var infoViewContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    var car : Car? {
        didSet{
            if car == nil{
                return
            }
            if let photo = car!.photo.scaleImageToWidth(newWidth: contentView.frame.width){
                imageView.image = photo
                imageView.sizeToFit()
            }
            else{
                let defaultPhoto = UIImage(named: "defaultcar")!
                imageView.image = defaultPhoto.scaleImageToWidth(newWidth: contentView.frame.width)
                imageView.sizeToFit()
            }
            switch car!.brand{
                case .bmw: brandLabel.text = "BMW"
                case .porsche: brandLabel.text = "PORSCHE"
                case .audi: brandLabel.text = "AUDI"
                case .astonmartin: brandLabel.text = "ASTON MARTIN"
            }
            modelLabel.text = car!.model
            colorLabel.text = car!.color
        }
    }
    
    
    static func cellHeight(image: UIImage, forWidth width: CGFloat) -> CGFloat{
        return image.scaleImageToWidth(newWidth: width)!.size.height
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        infoViewContainer.isHidden = true
        self.isUserInteractionEnabled = true
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
    
}
