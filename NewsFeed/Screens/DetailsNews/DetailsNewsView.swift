
import UIKit


class DetailsNewsView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsFullTextView: UITextView! {
        didSet {
            newsFullTextView.isScrollEnabled = false
            newsFullTextView.isEditable = false
        }
    }
    
    
    //MARK: - Open metods
    func showNews(_ news: NewsItem) {
        newsImageView.load(url: URL(string: news.imagePath!)!)
        newsTitleLabel.text = news.title
        newsFullTextView.text = news.fullText
    }
    
    
}
