
import Foundation
import Alamofire


protocol FeedParserImpl {
    func parseNews(urlPath: String, forse: Bool, completionHandler: ((Swift.Result<[NewsItem], NetworkResponseError>) -> Void)?)
}


final class FeedParser: NSObject, FeedParserImpl {
    
    //MARK: - Private properties
    private var newsItems: [NewsItem] = []
    private var newsItem = NewsItem()
    private var currentElement: String = ""
    
    private var parserComrletionHandler: ((Swift.Result<[NewsItem], NetworkResponseError>) -> Void)?
    
    
    //MARK: - FeedParserImpl
    func parseNews(urlPath: String, forse: Bool, completionHandler: ((Swift.Result<[NewsItem], NetworkResponseError>) -> Void)?)
    {
        self.parserComrletionHandler = completionHandler
        
        guard let url = URL(string: urlPath)
            else { return }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData)
        if !forse {
            urlRequest.timeoutInterval = 15
        }
        
        Alamofire.request(urlRequest)
            .responseData { response in
                switch response.result {
                    
                case .success(let data):
                    let parser = XMLParser(data: data)
                    parser.delegate = self
                    parser.parse()
                    
                case .failure(let error):
                    switch error._code {
                    case NSURLErrorTimedOut:
                        completionHandler?(.failure(NetworkResponseError.errorTimedOut))
                    case NSURLErrorNotConnectedToInternet:
                        completionHandler?(.failure(NetworkResponseError.notConnectedToInternet))
                    default:
                        completionHandler?(.failure(NetworkResponseError.anotherError))
                    }
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
        switch currentElement {
        case "title":
            newsItem.title += string.trimmingCharacters(in: .newlines)
        case "category":
            newsItem.category += string.trimmingCharacters(in: .whitespacesAndNewlines)
        case "yandex:full-text":
            newsItem.fullText += string.trimmingCharacters(in: .newlines)
        case "pubDate":
            newsItem.pubDate += string.getFormattedDate(currentFomat: "E, d MMM yyyy HH:mm:ss Z",
                                                        expectedFromat: "MM.dd.yyyy HH:mm") ?? ""
        default: break
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
        parserComrletionHandler?(.success(newsItems) )
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        parserComrletionHandler?(.failure(NetworkResponseError.anotherError))
    }
}
