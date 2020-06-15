
import UIKit


final class NewsFeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedParser = FeedParser()
        feedParser.parseNews(url: "https://www.vesti.ru/vesti.rss") { result in
            switch result {
            case .success(let feeds):
                break
            case .failure(let error):
                break
            }
        }
    }
    
}
