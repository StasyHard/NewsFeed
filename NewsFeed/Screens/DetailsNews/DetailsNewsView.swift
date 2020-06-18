
import UIKit
import Kingfisher


class DetailsNewsView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet weak var containertView: UIView!
    @IBOutlet weak var newsImageView: UIImageView! {
        didSet {
            newsImageView.layer.cornerRadius = 10
            newsImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsFullTextView: UITextView! {
        didSet {
            newsFullTextView.isScrollEnabled = false
            newsFullTextView.isEditable = false
        }
    }
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!
    
    
    //MARK: - Open metods
    func showNews(_ news: NewsItem) {
        
        guard let image = news.imagePath
            else {
                newsImageView.isHidden = true
                titleTopConstraint.isActive = false
                newsTitleLabel.topAnchor.constraint(equalTo: containertView.topAnchor,
                                                    constant: 16).isActive = true
                return
        }
        
        let url = URL(string: image)
        let processor = DownsamplingImageProcessor(size: newsImageView.bounds.size)
        newsImageView.kf.indicatorType = .activity
        newsImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .transition(.fade(0.1)),
                .cacheOriginalImage
            ])
        newsTitleLabel.text = news.title
        newsFullTextView.text = news.fullText
    }
    
    
}
