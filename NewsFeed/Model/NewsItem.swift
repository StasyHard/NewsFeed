
import Foundation


class NewsItem {
    
    var title: String
    var category: String
    var fullText: String
    var imagePath: String?
    var pubDate: String
    
    
        //MARK: - Init
    init() {
        self.title = ""
        self.category = ""
        self.fullText = ""
        self.imagePath = nil
        self.pubDate = ""
    }
}
