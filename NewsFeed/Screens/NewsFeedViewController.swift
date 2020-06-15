
import UIKit


final class NewsFeedViewController: UIViewController {
    
    //MARK: - Open properties
    weak var actionDelegate: NewsFeedViewActions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
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


extension NewsFeedViewController: NewsFeedViewEmplementation {
    
}
