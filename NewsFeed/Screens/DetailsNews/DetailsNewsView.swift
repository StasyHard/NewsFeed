
import UIKit


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
        
        guard let path = news.imagePath
            else {
                newsImageView.isHidden = true
                titleTopConstraint.isActive = false
                newsTitleLabel.topAnchor.constraint(equalTo: containertView.topAnchor,
                                                    constant: 16).isActive = true
                return
        }
        if let url = URL(string: path) {
            newsImageView.load(url: url)
        }
        newsTitleLabel.text = news.title
        newsFullTextView.text = news.fullText
    }
    
}
