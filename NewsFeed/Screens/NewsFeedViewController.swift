
import UIKit


final class NewsFeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://www.vesti.ru/vesti.rss") { items in
            items.forEach {
                print($0.imagePath)
            }
        }
    }
    
}
