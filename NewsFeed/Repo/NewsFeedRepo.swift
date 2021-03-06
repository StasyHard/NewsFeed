
import Foundation


protocol NewsFeedRepoImpl {
    func getNewsFeed(withFilter filter: String?, forse: Bool, complitionHandler: @escaping (Result<[NewsItem], NetworkResponseError>) -> Void)
    func getCategories(complitionHandler: @escaping ([String]) -> Void)
}


final class NewsFeedRepo {
    
    //MARK: - Private properties
    private var newsFeedParser: FeedParserImpl = {
      return FeedParser()
    }()
    private let newsFeedPath = "https://www.vesti.ru/vesti.rss"
    
    private var cachedNews = [NewsItem]()
}

extension NewsFeedRepo: NewsFeedRepoImpl {
    
    //MARK: - NewsFeedRepoImplementation
    func getNewsFeed(withFilter filter: String?, forse: Bool, complitionHandler: @escaping (Result<[NewsItem], NetworkResponseError>) -> Void)
    {
        newsFeedParser.parseNews(urlPath: newsFeedPath, forse: forse) { [weak self] result in
            
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

