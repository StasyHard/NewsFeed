
import Foundation


protocol NewsFeedRepoImplementation {
    func getNewsFeed(withFilter filter: String?, complitionHandler: @escaping (Result<[NewsItem], NetworkResponseError>) -> Void)
    func getCategories(complitionHandler: @escaping ([String]) -> Void)
}


final class NewsFeedRepo {
    
    //MARK: - Private properties
    private let newsFeedParser = FeedParser()
    private let newsFeedPath = "https://www.vesti.ru/vesti.rss"
    
    private var cachedNews = [NewsItem]()
}

extension NewsFeedRepo: NewsFeedRepoImplementation {
    
    //MARK: - NewsFeedRepoImplementation
    func getNewsFeed(withFilter filter: String?, complitionHandler: @escaping (Result<[NewsItem], NetworkResponseError>) -> Void)
    {
        newsFeedParser.parseNews(url: newsFeedPath) { [weak self] result in
            
            guard let `self` = self
                else { return }
            
            switch result {
            case .success(let data):
                self.cachedNews = data
                let filteredData = self.filterData(filter: filter, data: data)
                complitionHandler(.success(filteredData))
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
    
    
    //MARK: - Private metods
    private func filterData(filter: String?, data: [NewsItem]) -> [NewsItem] {
        if filter != nil {
            return data.filter { $0.category == filter }
        }
        return data
    }
}
