
import Foundation


final class NewsFeedRepo {
    
    //MARK: - Private properties
    private let newsFeedParser = FeedParser()
    private let newsFeedPath = "https://www.vesti.ru/vesti.rss"
    
    
    //MARK: - Open metods
    func getNewsFeed(complitionHandler: @escaping (Result<[NewsItem], NetworkResponseError>) -> Void)
    {
        newsFeedParser.parseNews(url: newsFeedPath) { result in
            switch result {
            case .success(let data):
                complitionHandler(.success(data))
            case .failure(let error):
                complitionHandler(.failure(error))
            }
        }
    }
}
