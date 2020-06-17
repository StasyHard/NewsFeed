
import Foundation

protocol NewsFeedRepoImplementation {
    func getNewsFeed(withFilter filter: String?, complitionHandler: @escaping (Result<[NewsItem], NetworkResponseError>) -> Void)
    func getCategories(complitionHandler: @escaping ([String]) -> Void)
}

extension NewsFeedRepoImplementation {
    func getNewsFeed(withFilter filter: String? = nil, complitionHandler: @escaping (Result<[NewsItem], NetworkResponseError>) -> Void) {
        return getNewsFeed(withFilter: filter, complitionHandler: complitionHandler)
    }
}


final class NewsFeedRepo {
    
    //MARK: - Private properties
    private let newsFeedParser = FeedParser()
    private let newsFeedPath = "https://www.vesti.ru/vesti.rss"
    
    private var cachedNews = [NewsItem]()
}

extension NewsFeedRepo: NewsFeedRepoImplementation {
    
    //MARK: - NewsFeedRepoImplementation
    func getNewsFeed(withFilter: String?, complitionHandler: @escaping (Result<[NewsItem], NetworkResponseError>) -> Void)
    {
        //фильтровать новости
        newsFeedParser.parseNews(url: newsFeedPath) { [weak self] result in
            switch result {
            case .success(let data):
                complitionHandler(.success(data))
                self?.cachedNews = data
            case .failure(let error):
                complitionHandler(.failure(error))
            }
        }
    }
    
    func getCategories(complitionHandler: @escaping ([String]) -> Void) {
        let category = Set(cachedNews.map { $0.category })
        let sortedCategory = Array(category).sorted { $0 < $1 }
        complitionHandler(sortedCategory)
    }
}
