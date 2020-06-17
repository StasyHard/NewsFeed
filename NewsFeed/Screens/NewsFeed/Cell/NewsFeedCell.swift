
import UIKit


class NewsFeedCell: UITableViewCell, ReusableView {
    
    //MARK: - IBOutlet
    @IBOutlet var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 5
            containerView.clipsToBounds = true
            containerView.dropShadow()
        }
    }
    @IBOutlet weak var titleNewsLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    //MARK: - Private metods
    private func setupUI() {
        self.backgroundColor = AppColors.backgroungColor
    }
}
