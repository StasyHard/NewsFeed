
import Foundation
import Alamofire


enum NetworkResponseStatus {
    case success
    case error(string: String?)
}


final class FeedParser: NSObject {
    
    private var newsItems: [NewsItem] = []
    private var currentElement: String = ""
    private var newsItem = NewsItem()
    
    private var parserComrletionHandler: (([NewsItem]) -> Void)?
    
    
    //MARK: - Open metods
    func parseFeed(url: String, completionHandler: (([NewsItem]) -> Void)?) {
        self.parserComrletionHandler = completionHandler
        
        Alamofire.request(url).responseData { response in
            switch response.result {
                
            case .success(let data):
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
                
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
}



//MARK: - XMLParserDelegate
extension FeedParser: XMLParserDelegate {
    
    func parserDidStartDocument(_ parser: XMLParser) {
        newsItems = []
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentElement = elementName
        if currentElement == "enclosure" {
            let url = attributeDict["url"]
            newsItem.imagePath = url
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if currentElement == "item" {
            switch currentElement {
                case "title": newsItem.title += string
                case "category": newsItem.category += string
                case "yandex:full-text": newsItem.fullText += string
                case "pubDate": newsItem.pubDate += string
                default: break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "item" {
            self.newsItems.append(newsItem)
            newsItem = NewsItem()
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserComrletionHandler?(newsItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
